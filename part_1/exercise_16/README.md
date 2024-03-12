# EXERCISE 1.16: CLOUD DEPLOYMENT 🤔
It is time to wrap up this part and run a containerized app in the cloud.

You can take any web-app, eg. an example or exercise from this part, your own app, or even the course material (see [devopsdockeruh/coursepage](https://hub.docker.com/r/devopsdockeruh/coursepage)) and deploy it to some cloud provider.

There are plenty of alternatives, and most provide a free tier. Here are some alternatives that are quite simple to use:

- [fly.io](https://fly.io/) (easy to use but needs a credit card even in the free tier)
- [render.com](https://render.com/) (bad documentation, you most likely need google)
- [heroku.com](https://www.heroku.com/) (has a free student plan through [GitHub Student Developer Pack](https://www.heroku.com/github-students))

If you know a good cloud service for the purposes of this exercise, please tell us (yes, we know about Amazon AWS, Google Cloud and Azure already... ).

Submit the Dockerfile, a brief description of what you did, and a link to the running app.

# Solution 💡

For this deployment, we will use [Render](https://render.com/). 
They have free options for deploying your docker image from DockerHub or GitHub which is neat!
Besides that, it is really simple to navigate and use.

I used my [repository](https://github.com/milistu/simple-backend) from the previous exercise.

## Create a New Web Service on Render

1. **Log In to Render**: 

    Go to the Render dashboard and sign in.

2. **Create a New Web Service**:

    Click on the "New+" button at the top right corner and select "Web
    Service". <br>
    Choose how would you like to deploy your web service:
     - Build and deploy from a Git repository
     - Deploy an existing image from a registry
    _**Note**: I used the first option. Even tho image exists on DockerHub and it is Public, I couldn't deploy it that way because the platform is `linux/arm64`, however, Render requires `linux/amd64`._

    Render will ask you to connect your GitHub or GitLab account if you haven’t already. But you can also just enter URL to the public repository.

3. **Configure Your Service**:

    **Service Name**: Give your service a name.
    
    **Region**: Choose the region closest to your users.

    **Branch**: Main in my case.

    **Runtime**: Choose "Docker".

    **Instance Type**: select **Free** option "For hobby projects".

    **Region**: Select the region that best suits your needs.

    **Add Environment Variables (Optional)**: We already set environment variables in `Dockerfile` which is the worst thing you can do but this is only for learning. The best practice would be to remove those variables and place them in these fields.

    We have also "Advanced" options that we do not need for this project but I encourage you to check them, to see what else is possible.

    Click "Create Web Service". Render will pull your Docker image from the registry and deploy it OR build it from the Dockerfile found in the GitHub repo.


4. **Access and Monitor Your Application**:

    Once the deployment process completes, Render will provide you with a `.onrender.com` subdomain to access your web service.
    You can monitor logs, set up custom domains, and configure other settings from your service dashboard on Render.

5. **Using our app**:

    Copy the link that Render generated for your web-app, it looks something like this:
    ```
    https://<your-app-name>.onrender.com/docs
    ```
    We added `/docs` at the end, so we can access Swagger and you can test it right away even from your phone or laptop.
    
    Go to Authorize and input your username and password to get the required token.

    In our example username:
    ```
    username=johndoe
    password=ThisPasswordIsTheBest,TrustMe!
    ```
    Now you can test one of end-points (eg. image, audio, text).

## My App:

A detailed description of an app can be found on the [repository](https://github.com/milistu/simple-backend).

To access the app you can go to:
```bash
https://reverse-all.onrender.com/docs
```

Enter the credentials in **Authorize**:
- Username: **johndoe**
- Password: **BestPassword!**

Try different "Reverse" endpoints!

_**Note**: Audio endpoint can't be tested/PLayed through Swagger UI._