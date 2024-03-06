# EXERCISE 3.2: A DEPLOYMENT PIPELINE TO A CLOUD SERVICE 🤔
In [Exercise 1.16](https://github.com/milistu/DevOpsWithDocker/tree/main/part_1/exercise_16) you deployed a containerized app to a cloud service.

Now it is time to improve your solution by setting up a deployment pipeline for it so that every push to GitHub results in a new deployment to the cloud service.

You will most likely find a ready-made GitHub Action that does most of the heavy lifting your you... Google is your friend!

Submit a link to the repository with the config. The repository README should have a link to the deployed application.

# Solution 💡

## 1. Create GitHub workflow:
We will create `.github/workflows/deploy.yaml`. Using [Render's deployment action](https://github.com/marketplace/actions/render-deploy-action?version=v0.0.8) our file looks like this: 
```yaml
name: Release Reverse All API 

on:
    push:
        branches:
            - main

jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v4
            - 
                name: Render Deploy Action
                uses: johnbeynon/render-deploy-action@v0.0.8
                with:
                    service-id: ${{ secrets.MY_RENDER_SERVICE_ID }}
                    api-key: ${{ secrets.MY_RENDER_API_KEY }}
```

## 2. Add secrets:

We need to add our render credentials to GitHub secrets. On your GitHub repo open `Settings -> Secrets and Variables -> Actions`. <br>
Here we will add:

- **MY_RENDER_SERVICE_ID**: When viewing a service in the Render dashboard grab this value from the URL - it will start with `srv-`
- **MY_RENDER_API_KEY**: You can create one under `Account Settings -> API Keys`

## 3. Make some changes:
We will push some changes to our endpoint and see if those changes are active.

One thing that annoys me is that our credentials for login are to long. I will create another user in our database and see if we can log in with his credentials on our endpoint. 

For that I will be using `database-dev.ipynb` notebook with detail description and guidence.

When you push your changes, chek for activity in Actions tab on your repository, and also check logs on your Render endpoint.

## 4. Check results:
You can now go to your Render endpoint that looks something like this:
```
https://<your-app-name>.onrender.com/docs
```

And try to login with your new password.

That's it, we implemented a working GitHub action and automatized our deployment! Great job! 🍾

