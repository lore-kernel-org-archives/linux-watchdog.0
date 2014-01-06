Return-Path: <wimvs@spo001.leaseweb.com>
Date: Mon, 6 Jan 2014 21:48:45 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3] watchdog: GPIO-controlled watchdog
Message-ID: <20140106204845.GA16713@spo001.leaseweb.com>
References: <1385798072-3886-1-git-send-email-shc_work@mail.ru> <529B78DC.7070200@roeck-us.net> <1385924607.556195103@f310.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1385924607.556195103@f310.i.mail.ru>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Alexander,

> > > +	/* Disallow values lower than 2 and higher than 65535 ms */
> > > +	if ((hw_margin < 2) || (hw_margin > 65535))
> > 
> > Unnecessary ( ).
> 
> This can be corrected during merge. Isn't it? Or you expect v4?

Yes, can be corrected during merge window, so no v4 expected.

Kind regards,
Wim.
