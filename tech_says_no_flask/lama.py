from llamaapi import LlamaAPI


llama = LlamaAPI("LL-OMRR5S1cTUrbM3Bv1bq5Y3CVx9PGpwWPLoFtAVCJVWFPqwAT9eqCqVQuE2pB0ra6")
prefix = "I am a female victim of some kind of phisical or verbal abuse. I am feeling very bad and I don't know what to do. Can you help me by kindly answering my question,"


def get_content(response):
    try:
        print("resp")
        print(response)
        return True, response["choices"][0]["message"]["content"]
    except Exception as e:
        print("Error in get_content: ", e)
        return False, response
    

def answer_question(question, generalization_coefficient=0.5):

    message = f"{prefix} {question}? [generalization_coefficient={generalization_coefficient}]"
    
    api_request_json = {
        "messages": [
            {"role": "user", "content": message},
        ],
        "functions": [],
        "stream": False,
        "generalization_coefficient": generalization_coefficient,
        "language": "en"
    }
    
    response = llama.run(api_request_json)
    return response.json()