Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
Message-ID: <1509101921.5684.3.camel@arista.com>
Subject: Re: [PATCH v3 4/4] watchdog: i6300esb: remove info message and
 version number
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Fri, 27 Oct 2017 11:58:41 +0100
In-Reply-To: <bf7f6cc8-73da-19a1-d54c-438b5ede1b57@roeck-us.net>
References: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
	 <20171026161016.3198-4-rrendec@arista.com>
	 <bf7f6cc8-73da-19a1-d54c-438b5ede1b57@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 2017-10-26 at 18:05 -0700, Guenter Roeck wrote:
> On 10/26/2017 09:10 AM, Radu Rendec wrote:
> > The initial info message (early in the esb_probe() function) is not very
> > useful and we already have a message on successful probe, which includes
> > device identification. If the probe fails (e.g. PCI related errors),
> > additional messages are printed anyway.
> > 
> > The version number was only used in the initial info message. Other than
> > that, it serves no useful purpose and it ran out of favor upstream
> > anyway.
> > 
> > Signed-off-by: Radu Rendec <rrendec@arista.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> ... and thanks a lot for doing this!

You're welcome. Thanks for reviewing this and for all the input!

We also benefit from this work - on the long run, it's always easier to
work with upstream and get changes accepted than maintain custom
patches.

Best,
Radu
