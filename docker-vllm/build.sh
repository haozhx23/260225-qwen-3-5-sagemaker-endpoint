export REGION=us-east-2
export ACCOUNT_ID=1234567890
export REPOSITORY_NAME=vllm
export TAG=qwen35

full_name="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY_NAME}:${TAG}"

DOCKER_BUILDKIT=1 docker build . --tag $REPOSITORY_NAME:$TAG --file Dockerfile

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# If the repository doesn't exist in ECR, create it.
aws ecr describe-repositories --region ${REGION} --repository-names "${REPOSITIRY_NAME}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    aws ecr create-repository --region ${REGION} --repository-name "${REPOSITORY_NAME}" > /dev/null
fi

docker tag $REPOSITORY_NAME:$TAG ${full_name}
docker push ${full_name}
