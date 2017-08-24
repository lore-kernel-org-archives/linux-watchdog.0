Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170814150105.GG14491@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-3-linus.walleij@linaro.org> <20170814150105.GG14491@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Aug 2017 22:45:27 +0200
Message-ID: <CACRpkdb_UkQdg0H-WA+9tbW5_9UX2-3Ezoyww=HXuUGi=8aH8A@mail.gmail.com>
Subject: Re: [PATCH 02/11] watchdog: gemini/ftwdt010: rename driver and symbols
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 14, 2017 at 5:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sat, Aug 12, 2017 at 08:43:09PM +0200, Linus Walleij wrote:

>> -config GEMINI_WATCHDOG
>> -     tristate "Gemini watchdog"
>> -     depends on ARCH_GEMINI
>> +config FTWDT010_WATCHDOG
>> +     tristate "Faraday Technology FTWDT010 watchdog"
>> +     depends on ARM || COMPILE_TEST
>
> Did you test this ? I am kind of wary about COMPILE_TEST in watchdog drivers.
> I tried to enable that a while ago, and we had to spend a couple of releases
> fixing the fallout (even though I had tried to make sure that everything
> builds).

Incidentally, yes!

I push my tree to kernelorg where the zeroday autobuilders pick it up
and compile all kind of archs.

I'm pushing the updated patches too.

The big culprit used to be um linux, since it doesn't do MMIO.
But I think that has been solved recently because I don't see
complaints about it anymore.

Yours,
Linus Walleij
