from flask import Flask, request, jsonify
from transformers import GPT2Tokenizer, TFGPT2LMHeadModel
import tensorflow as tf
import re
import string

app = Flask(__name__)

# Load tokenizer and model
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
tokenizer.clean_up_tokenization_spaces = False 
model = TFGPT2LMHeadModel.from_pretrained('gpt2')

# unwanted punctuation characters
unwanted_punctuation = set(string.punctuation + ' ')

# function to filter out non-alphabetic tokens and avoid duplicates
def is_valid_word(word):
    # remove any non-alphabetic characters and check if the word is not empty
    return bool(re.match(r'^[a-zA-Z]+$', word))

def get_unique_suggestions(input_text, k=10):  # Reduced k for faster results
    seen_words = set()
    suggestions = []

    for _ in range(10):  # Limit iterations to avoid long loops
        # Tokenize the input text
        input_ids = tokenizer.encode(input_text, return_tensors='tf')
        
        # Get the model's outputs
        output = model(input_ids)
        
        # Extract logits for the next token prediction
        logits = output.logits[:, -1, :]  # We want the last token's logits
        
        # Get the probabilities by applying softmax
        probs = tf.nn.softmax(logits, axis=-1)
        
        # Get the top-k token indices and their probabilities
        top_k_indices = tf.math.top_k(probs, k=k).indices.numpy().flatten()

        # Decode the top-k tokens
        new_suggestions = [tokenizer.decode([token_id]).strip() for token_id in top_k_indices]
        
        # Filter out unwanted punctuation, non-alphabetic tokens, and duplicates
        for word in new_suggestions:
            normalized_word = word.lower()
            if (not set(word).intersection(unwanted_punctuation) and 
                is_valid_word(word) and 
                normalized_word not in seen_words):
                seen_words.add(normalized_word)
                suggestions.append(word)
                
        # Stop if the number of unique suggestions is sufficient
        if len(suggestions) >= k:
            break
    
    print(f"Final Suggestions: {suggestions}")
    return suggestions[:k]  # Return at most k suggestions

@app.route('/suggest', methods=['POST'])
def suggest():
    print("sugessttt")
    data = request.json
    app.logger.info(f"Request data: {data}")
    selected_phrases = data.get('selected_phrases', [])
    print(f"Selected phrases: {selected_phrases}")
    suggestions = get_unique_suggestions(selected_phrases, k=50)
    print(f"Generated suggestions: {suggestions}")

    return jsonify(suggestions)

@app.route('/test', methods=['GET'])
def test():
    print("testttt")
    app.logger.info("Test endpoint called")
    return jsonify({"message": "Connection successful!"})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)

