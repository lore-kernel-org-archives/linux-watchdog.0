Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1483500343-27113-4-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net> <1483500343-27113-4-git-send-email-linux@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Jan 2017 20:39:58 +0100
Message-ID: <CACRpkdbsZB-yKCY-fzLw-OK6YmXycTKF5Hep094W8HbQxj+ptg@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog: coh901327_wdt: Use dev variable instead of pdev->dev
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Use a local dev variable instead of dereferencing pdev->dev several
> times in the probe function to make the code easier to read.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
