Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38030 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbbBRRuQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 12:50:16 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YO8lL-0041oj-TB
	for linux-watchdog@vger.kernel.org; Wed, 18 Feb 2015 17:50:16 +0000
Date: Wed, 18 Feb 2015 09:50:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	nicolas.ferre@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150218175002.GA28529@roeck-us.net>
References: <54B53160.6060309@roeck-us.net>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
 <54E49AA5.40008@roeck-us.net>
 <20150218151713.7a718311@bbrezillon>
 <54E4A6C4.4070706@roeck-us.net>
 <20150218160033.GK11529@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150218160033.GK11529@piout.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 18, 2015 at 05:00:33PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> On 18/02/2015 at 06:50:44 -0800, Guenter Roeck wrote :
> > >>>   Optional properties:
> > >>>   - timeout-sec: Contains the watchdog timeout in seconds.
> > >>>+- early-timeout-sec: If present, specifies a timeout value in seconds
> > >>>+  that the driver keeps on ticking the watchdog HW on behalf of user
> > >>>+  space. Once this timeout expires watchdog is left to expire in
> > >>>+  timeout-sec seconds. If this propery is set to zero, watchdog is
> > >>>+  started (or left running) so that a reset occurs in timeout-sec
> > >>>+  since the watchdog was started.
> > >>>
> > >>>   Example:
> > >>>
> > >>>   watchdog {
> > >>>   	 timeout-sec = <60>;
> > >>>+	 early-timeout-sec = <120>;
> > >>
> > >>That is not a generic property as you defined it; if so,
> > >>it would have to be implemented in the watchdog core code,
> > >>not in the at91 code. You'll have to document it in the bindings
> > >>description for at91sam9_wdt.
> > >
> > >Then, if this is a controller specific property, it should be defined
> > >with the 'atmel,' prefix.
> > >We're kind of looping here: the initial discussion was "is there a need
> > >for this property to be a generic one ?", and now you're saying no,
> > >while you previously left the door opened.
> > >
> > >Tomi is proposing a generic approach, as you asked him to. I agree that
> > >parsing the property in core code and making its value part of the
> > >generic watchdog struct makes sense (that's what I proposed to Tomi a
> > >few weeks ago).
> > >
> > Hmm ... the problem here is that the property description creates the
> > assumption or expectation that the property is used if defined,
> > which is not the case.
> > 
> > I am not sure how to best resolve this. Maybe a comment in the property
> > description stating that implementation of is device (driver) dependent ?
> > After all, that is true for the timeout-sec property as well.
> > 
> 
> I would leave it in the generic file and state that it may not be
> implemented in the driver. That way, the property is documented for new
> driver writers.
> 
Yes, that would be fine ok me.

Thanks,
Guenter
