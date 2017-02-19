Return-path: <alexandre.belloni@free-electrons.com>
Date: Mon, 20 Feb 2017 00:52:13 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when
 watchdog is disabled
Message-ID: <20170219235213.qcxfne5yvs3uzwg3@piout.net>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
 <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
 <20170217151625.hv2vn5imx2kyeftt@piout.net>
 <c9f336fd-8761-7999-4ac0-cf68eb6c8ba1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f336fd-8761-7999-4ac0-cf68eb6c8ba1@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 19/02/2017 at 08:57:35 -0800, Guenter Roeck wrote:
> > > That means if the watchdog is running, the timeout would not be updated.
> > > It should be updated no matter if it is running or not.
> > > 
> > 
> > No, it is enabling the watchdog, then changing WDV and WDD and finally
> > disabling the watchdog if necessary. So, WDV and WDD are always changed.
> > 
> You are correct. Sorry for the noise.
> 
> Seems odd that the watchdog must be _running_ to change the timeout.
> Usually, if there is a restriction, it is the opposite. I hope this
> doesn't cause race conditions, where the watchdog fires immediately
> after being enabled due to a low timeout.
> 

While it is difficult to reproduce, I can confirm it races and sometimes
reset the SoC without any good reason. It doesn't matter whether it is
disabled or not

I've raised the issue at Atmel last Thursday so I don't have any answer
yet.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
