# Qwen3.5 SageMaker Endpoint 部署

## 1. 构建镜像

修改 `docker-vllm/build.sh` 中的账号和区域：
```bash
ACCOUNT_ID=<your-account-id>
REGION=<your-region>
```

构建并推送镜像：
```bash
cd docker-vllm && ./build.sh
```

## 2. 部署 Endpoint

修改 `deploy_qwen35_vllm.py` 中的配置（REGION, IAM_ROLE, INFERENCE_IMAGE 等），然后运行：
```bash
python deploy_qwen35_vllm.py
```

## 3. 调用 Endpoint

修改 `invoke_endpoint.py` 中的 `ENDPOINT_NAME`，然后运行：
```bash
python invoke_endpoint.py
```
