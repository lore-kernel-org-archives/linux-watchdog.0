Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36748 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbbEVPF5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 11:05:57 -0400
Date: Fri, 22 May 2015 08:05:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fu Wei <fu.wei@linaro.org>
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
Message-ID: <20150522150554.GB2930@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
 <555ECD04.6000404@offcode.fi>
 <CADyBb7sZWgNnEoTfaYm6=YcbWgEYRMcaNAdX9Y7B6W9pg+gOmg@mail.gmail.com>
 <555EEFDB.2030907@offcode.fi>
 <CADyBb7uh-6=ihfrKHBVXDzAKAE-_GqLXTPJa5_7Gw2R71pyeUg@mail.gmail.com>
 <555F2DED.2010200@roeck-us.net>
 <CADyBb7swfV9eQKC2FxiaK=RFq9JR8fmq1BcTeWOp57i_TrXaBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7swfV9eQKC2FxiaK=RFq9JR8fmq1BcTeWOp57i_TrXaBA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 22, 2015 at 10:38:32PM +0800, Fu Wei wrote:
> Hi Guenter.
> 
> Sorry for my poor English .
> let me explain this :
> 
> On 22 May 2015 at 21:23, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 05/22/2015 03:46 AM, Fu Wei wrote:
> >>
> >> Hi Timo,
> >>
> > [ ... ]
> >
> >> So I am still trying to improve pretimeout support :-)
> >
> >
> > Is there anything still missing from it ?
> >
> >> If I can make pretimeout merged, may be you can try pretimeout to
> >> implement early_timeout_sec function?
> >
> >
> > Not sure how one would or even could do that.
> >
> > Do you mean "implement early_pretimeout_sec", by any chance ?
> 
> I mean: using pretimeout to implement the function you want, instead
> of early_pretimeout_sec
> 
How would this work if the watchdog hardware doesn't support pretimeout ?

Pretimeout and early timeout are two logically different functions, with
different goals, so I don't entirely (if at all) understand why it would
make sense to tie them together.

Can you elaborate why you think this would be a good idea ?

Thanks,
Guenter
