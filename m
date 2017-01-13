Return-path: <morbidrsa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1484091325-9199-31-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net> <1484091325-9199-31-git-send-email-linux@roeck-us.net>
From: Johannes Thumshirn <morbidrsa@gmail.com>
Date: Fri, 13 Jan 2017 09:08:16 +0100
Message-ID: <CAGH8bx4UeABB0UNDsR+zTB2cER_Lcnguk_+d6oSKG2N0hYYLhA@mail.gmail.com>
Subject: Re: [PATCH 30/62] watchdog: mena21_wdt: Convert to use device managed
 functions and other improvements
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

> Am 11.01.2017 12:38 vorm. schrieb "Guenter Roeck" <linux@roeck-us.net>:
>
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Drop remove function
> - Drop unnecessary mutex_destroy() on allocated data
> - Use devm_watchdog_register_driver() to register watchdog device
>
> Cc: Johannes Thumshirn <morbidrsa@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Looks good,
Acked-by: Johannes Thumshirn <jth@kernel.org>
