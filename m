Return-path: <Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Support
 Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 12/62] watchdog: da9055_wdt: Convert to use device
 managed functions
Date: Tue, 17 Jan 2017 13:58:09 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A77D22@SW-EX-MBX01.diasemi.com>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484091325-9199-13-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-13-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 10 January 2017 23:34, Guenter Roeck wrote:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
>=20
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>=20
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device
>=20
> Cc: Support Opensource <support.opensource@diasemi.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
