from flask import Flask, request, jsonify
import tensorflow as tf
from transformers import TFBertForMaskedLM, BertTokenizer
import regex

app = Flask(__name__)

# Load pre-trained model and tokenizer
models = {
    "JA": TFBertForMaskedLM.from_pretrained('cl-tohoku/bert-base-japanese'),
    "ZH": TFBertForMaskedLM.from_pretrained('bert-base-chinese'),
    "EN": TFBertForMaskedLM.from_pretrained('bert-base-uncased')
}

tokenizers = {
    "JA": BertTokenizer.from_pretrained('cl-tohoku/bert-base-japanese'),
    "ZH": BertTokenizer.from_pretrained('bert-base-chinese'),
    "EN": BertTokenizer.from_pretrained('bert-base-uncased')
}

def is_chinese(word):
    return regex.search(r'\p{Han}', word) is not None

def predict_next_word(input_text, language_token):
    model = models[language_token]
    tokenizer = tokenizers[language_token]

    input_text = input_text.replace('[MASK]', tokenizer.mask_token)
    inputs = tokenizer(input_text, return_tensors='tf', add_special_tokens=True)
    
    # Find the position of the mask token
    input_ids = inputs['input_ids']
    mask_token_index = tf.where(input_ids == tokenizer.mask_token_id)
    
    # Get the logits for the mask token
    token_logits = model(inputs).logits
    mask_token_logits = token_logits[0, mask_token_index[0][1], :]
    
    # Initialize an empty list to store valid words
    valid_words = set()
    top_k = 50
    
    while len(valid_words) < 50:
        tokens = tf.math.top_k(mask_token_logits, top_k).indices.numpy()
        words = [tokenizer.decode([token]) for token in tokens]
        # Filter out punctuation and add valid words to the list
        if language_token == "ZH":
            valid_words.update([word for word in words if is_chinese(word)])
        else:
            valid_words.update([word for word in words if all(c.isalpha() or c.isdigit() for c in word)])
        top_k += 10
    
    return list(valid_words)[:50]

@app.route('/suggest', methods=['POST'])
def suggest():
    data = request.json
    selected_phrases = data.get('selected_phrases', [])
    language_code = data.get('language_code', 'EN').upper()
    selected_phrases_to_string = ' '.join(selected_phrases) + " [MASK]"
    suggestions = predict_next_word(selected_phrases_to_string, language_code)

    return jsonify(suggestions)

@app.route('/test', methods=['GET'])
def test():
    print("testttt")
    return jsonify({"message": "Connection successful!"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)