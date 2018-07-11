Return-Path: <sudeep.holla@arm.com>
Return-path: <sudeep.holla@arm.com>
Date: Wed, 11 Jul 2018 16:30:16 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Srinath Mannam <srinath.mannam@broadcom.com>, wim@linux-watchdog.org,
	Ray Jui <ray.jui@broadcom.com>,
	Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
	Vikram Prakash <vikram.prakash@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-watchdog@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Message-ID: <20180711153015.GA10578@e107155-lin>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
 <20180710213557.GC27827@roeck-us.net>
 <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
 <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jul 11, 2018 at 06:47:49AM -0700, Guenter Roeck wrote:
> On 07/11/2018 06:22 AM, Srinath Mannam wrote:
> >Hi Guenter,
> >
> >Thank you very much for all the help with your feedback and review
> >comments to complete the changes very fast.
> >
> >About the documentation..
> >I have gone through few similar patches available in the kernel are
> >listed in the mail of previous version.
> >No documentation available in Linux for the properties used in those
> >patches also.
>
> " No documentation available _in Linux_"
>
> Emphasis mine. Yes, I noticed this as well. I was asking for a reference
> to documentation _outside_ Linux. Sorry for not being more specific.

Typically new properties needs to registered or discussed in dsd@acpica.org
Though there's almost no activity on that list for more than a year now.
IIRC, the thread[1] gives kind of agreement that was reached after
elaborate discussion on _DSD properties.

--
Regards,
Sudeep

[1] https://lists.acpica.org/pipermail/dsd/2015-December/000027.html
