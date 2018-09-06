# buddy

Buddy is unofficial buddybuild client based on public APIs.

I was looking for a buddybuild client for checking and downloading latest builds. So I started coding!

It's written using clean code and functional programming. 

✅ Unit tested

## HOW IT WORKS

Using default values (easy way, no stress :))

    let config = Configuration(token: "<token here>",
                               baseUrl: "<base url here>")

    let buddy = BuddyService(configuration: config)

Customizing service and session:

    let session = Session()
    let dispatcher = DefaultDispatcher()

    let service = Service(session: session,
                          dispatcher: dispatcher)

    let configuration = Configuration(token: "<token here>",
                                      baseUrl: "<base url here>",
                                      service: service)

    let buddy = BuddyService(configuration: configuration)

## COMMANDS

    • func getApps(completion: @escaping ((Result<[AppResponse]>) -> Void))

    • func getBuilds(appId: String,
                     size: Int = Constants.URL.limitValue,
                     status: BuildStatus? = nil,
                     completion: @escaping ((Result<[BuildResponse]>) -> Void))

    • func getBuild(number: String,
                    completion: @escaping ((Result<BuildResponse>) -> Void))