Return-path: <esbenhaabendal@gmail.com>
MIME-Version: 1.0
Sender: esbenhaabendal@gmail.com
In-Reply-To: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
From: Esben Haabendal <esben.haabendal@gmail.com>
Date: Wed, 24 May 2017 16:19:37 +0200
Message-ID: <CAOR3GqXxYZFGiCJ9GA9-i7hyfqjnLEx=gdySRyZS+CWTghfutw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] watchdog: allow setting deadline for opening /dev/watchdogN
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On 22 May 2017 at 16:06, Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
>
> Rasmus Villemoes (3):
>   watchdog: introduce watchdog_worker_should_ping helper
>   watchdog: introduce watchdog.open_timeout commandline parameter
>   watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
>
>  Documentation/watchdog/watchdog-parameters.txt | 10 +++++++
>  drivers/watchdog/Kconfig                       |  9 +++++++
>  drivers/watchdog/watchdog_dev.c                | 37 +++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 4 deletions(-)


Thanks. This is definitely useful for embedded applications.

If this get merged, it should be able to replace several out-of-tree
hacks to accomplish the same thing.

For all 3 patches:
Reviewed-by: Esben Haabendal <esben@haabendal.dk>

/Esben
