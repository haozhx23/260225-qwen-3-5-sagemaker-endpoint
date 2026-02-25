import boto3
import json

endpoint_name = "qwen35-260225-092242"
runtime = boto3.client("sagemaker-runtime", region_name="us-east-2")

payload = {
    "messages": [{"role": "user", "content": "Hello, who are you?"}],
    "chat_template_kwargs": {"enable_thinking": True}
}

response = runtime.invoke_endpoint(
    EndpointName=endpoint_name,
    ContentType="application/json",
    Body=json.dumps(payload)
)

res = json.loads(response["Body"].read())
print("Response:", res["choices"][0]["message"]["content"])
print("Usage:", res["usage"])
