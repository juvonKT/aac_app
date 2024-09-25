import numpy as np
import tensorflow as tf
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Embedding, LSTM, Dense
import pickle
import os


script_dir = os.path.dirname(os.path.realpath(__file__))
file_path = os.path.join(script_dir, 'eng_data.txt')

with open(file_path, 'r') as file:
    text = file.read()

tokenizer = Tokenizer()
tokenizer.fit_on_texts([text])
total_words = len(tokenizer.word_index) + 1

input_sequences = []
for line in text.split('\n'):
    token_list = tokenizer.texts_to_sequences([line])[0]
    for i in range(1, len(token_list)):
        n_gram_sequence = token_list[:i+1]
        input_sequences.append(n_gram_sequence)

max_sequence_len = max([len(seq) for seq in input_sequences])
input_sequences = np.array(pad_sequences(input_sequences, maxlen=max_sequence_len, padding='pre'))

X = input_sequences[:, :-1]
y = input_sequences[:, -1]

y = np.array(tf.keras.utils.to_categorical(y, num_classes=total_words))

model = Sequential()
model.add(Embedding(total_words, 100, input_length=max_sequence_len-1))
model.add(LSTM(150))
model.add(Dense(total_words, activation='softmax'))
print(model.summary())

model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(X, y, epochs=100, verbose=1)

def suggest_words(input_text, model, tokenizer, n=5):
    input_sequence = tokenizer.texts_to_sequences([input_text])[0]
    input_sequence = pad_sequences([input_sequence], maxlen=max_sequence_len - 1, padding='pre')
    predicted_probs = model.predict(input_sequence, verbose=0)[0]
    predicted_indices = np.argsort(predicted_probs)[-n:][::-1]  # Get the top n predictions
    
    suggested_words = [tokenizer.index_word[i] for i in predicted_indices]
    return suggested_words

suggested_word = suggest_words( "How can I", model, tokenizer, 50)
print(f"Suggested word: {suggested_word}")


# Save the model
model.save('word_suggestion_model.h5')

# Save the tokenizer
with open('tokenizer.pkl', 'wb') as handle:
    pickle.dump(tokenizer, handle, protocol=pickle.HIGHEST_PROTOCOL)

# Load the model and tokenizer for offline use
loaded_model = tf.keras.models.load_model('word_suggestion_model.h5')

with open('tokenizer.pkl', 'rb') as handle:
    loaded_tokenizer = pickle.load(handle)

# # Example usage of the loaded model
# loaded_suggested_word = suggest_words("I love to", loaded_model, loaded_tokenizer)
# print(f"Suggested word (loaded model): {loaded_suggested_word}")
