Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Jan 2017 20:38:03 +0100
Message-ID: <CACRpkdbb9O=zRNox9RO9bNkAJ0grZ7vHy+8=9udJj0_Gw+k5hA@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: coh901327_wdt: Simplify error handling in
 probe function
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Checking if there is no error followed by a goto if there is one is
> confusing. Reverse the logic.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
