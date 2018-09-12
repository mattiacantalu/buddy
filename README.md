[![Swift version](https://img.shields.io/badge/swift-4.1-red.svg)](https://swift.org/blog/swift-4-1-released/)

# buddy

Buddy is unofficial (simple) buddybuild client based on public APIs.

I was looking for a buddybuild client for checking and downloading latest builds. So I started coding!

✅ Clean code

✅ Functional programming

✅ Unit tested

## Configuration

Using default values (easy way, no stress :))

    let config = Configuration(token: "<token>",
                               baseUrl: "<base url>")

    let buddy = BuddyService(configuration: config)

Customizing service and session:

    let session = Session()
    let dispatcher = DefaultDispatcher()

    let service = Service(session: session,
                          dispatcher: dispatcher)

    let configuration = Configuration(token: "<token>",
                                      baseUrl: "<base url>",
                                      service: service)

    let buddy = BuddyService(configuration: configuration)

## Commands

    • func getApps(completion: @escaping ((Result<[AppResponse]>) -> Void))

    • func getBuilds(appId: String,
                     size: Int = Constants.URL.limitValue,
                     status: BuildStatus? = nil,
                     completion: @escaping ((Result<[BuildResponse]>) -> Void))

    • func getBuild(number: String,
                    completion: @escaping ((Result<BuildResponse>) -> Void))

## Implementation

    let buddy = BuddyService(configuration: <configuration>)

    buddy.getBuilds(appId: app.id{ result in
        switch result {
        case .success(let response):
            self.builds = response
        case .failure(let error):
            print("error: \(error)")
        }
    }


# Requirements
• Xcode 9+

• Swift 4.1


# Contributor
• [Gioevi90](https://github.com/Gioevi90)
