Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170814160932.GD7025@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-9-linus.walleij@linaro.org> <20170814160932.GD7025@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Aug 2017 22:34:56 +0200
Message-ID: <CACRpkdaNkzWYwksEaMdNKvRo_eimSvPaZhjfwgDLgGQt38mjSg@mail.gmail.com>
Subject: Re: [PATCH 08/11] watchdog: ftwdt010/moxart: Merge MOXA ART into FTWDT010
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 14, 2017 at 6:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>>       default ARCH_GEMINI
>> +     default ARCH_MOXART
>
> Can one have more than one default statement ? What is the semantics ?
> Just making sure that it isn't "last one wins".

I would guess logical OR but to be on the safe side, I will
convert these to an explicit default (ARCH_GEMINI || ARCH_MOXART)

Yours,
Linus Walleij
