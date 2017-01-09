Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1483500343-27113-2-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net> <1483500343-27113-2-git-send-email-linux@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Jan 2017 20:38:56 +0100
Message-ID: <CACRpkdaLzus0va_5EchqzXChfNm1Ri4tv9VAGvCRMkfj-eks2w@mail.gmail.com>
Subject: Re: [PATCH 2/4] watchdog: coh901327_wdt: Keep clock enabled after
 loading driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Enabling the clock before accessing chip registers and disabling it
> afterwards does not really make sense and only adds complexity to
> the driver. In addition to that, a comment int the driver suggests
> that it does not serve a useful purpose either.
>
> "The watchdog block is of course always clocked, the
>  clk_enable()/clk_disable() calls are mainly for performing reference
>  counting higher up in the clock hierarchy."
>
> Just keep the clock enabled instead.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
