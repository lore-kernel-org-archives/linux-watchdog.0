Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1483500343-27113-3-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net> <1483500343-27113-3-git-send-email-linux@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Jan 2017 20:39:28 +0100
Message-ID: <CACRpkda1aTWaj1gN_y2L_yD8T9rFX4K7aL3+BukTjq1MRD7E6Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] watchdog: coh901327_wdt: Use devm_ioremap_resource to
 map resources
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Map resources using devm_ioremap_resource() to simplify error handling.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
