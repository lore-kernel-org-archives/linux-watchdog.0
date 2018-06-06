Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180606162404.GA10066@roeck-us.net>
References: <1528219113-29014-1-git-send-email-geert+renesas@glider.be> <20180606162404.GA10066@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 18:36:25 +0200
Message-ID: <CAMuHMdW+R0Lq_SRGjzvd_docYOP6sWG1aZexsyw9gf43YeYBjg@mail.gmail.com>
Subject: Re: dt-bindings: watchdog: renesas-wdt: Add support for the R8A77990 wdt
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi G=C3=BCnter,

On Wed, Jun 6, 2018 at 6:24 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 05, 2018 at 07:18:33PM +0200, Geert Uytterhoeven wrote:
>> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>>
>> Document support for the Watchdog Timer (WDT) Controller in the Renesas
>> R-Car E3 (R8A77990) SoC.
>>
>> No driver update is needed.
>>
>> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This refuses to apply for me. What tree is it based on ?

Yesterday's next.
Still applies fine against next-20180606, which includes watchdog next?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
