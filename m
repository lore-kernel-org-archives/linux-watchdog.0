Return-path: <panand@redhat.com>
Date: Thu, 5 May 2016 23:50:31 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160505182031.GB12434@dhcppc6.redhat.com>
References: <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com>
 <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com>
 <572A2099.4070901@codeaurora.org>
 <20160505164300.GA16914@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160505164300.GA16914@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

+kexec list

Hi Guenter,

On 05/05/2016:09:43:00 AM, Guenter Roeck wrote:
> On Wed, May 04, 2016 at 11:17:29AM -0500, Timur Tabi wrote:
> > Pratyush Anand wrote:
> > >Its unique to SBSA because you have very little timeout here. kexec-tools
> > >upstream does not have any mechanism to handle watchdog timeout. Lets say even
> > >if we implement a framework there, the best it can do is to ping the watchdog
> > >again.
> > 
> > Ok, so it's more accurate to say that kexec has a minimum watchdog timeout
> > requirement.  What happens if the system admin sets the timeout to 5 seconds
> > arbitrarily?  The system will reset during kexec, no matter which hardware
> > is used.
> > 
> > This still sounds like a band-aid to me.  We're just assuming that we need a
> > timeout of at least 20 seconds to support kexec.  Frankly, this still sounds
> > like a problem the kexec developers needs to acknowledge and deal with.
> > 
> > Still I'm okay with a patch that extends the timeout by programming WCV, but
> > it has to be commented as a hack specifically to support kexec because the
> > timeout might be too short.  Then Wim can decide whether he supports such
> > changes.
> > 
> I don't even understand how kexec-tools is involved in the first place.
> kexec-tools sounds like user space, which should execute _after_ the kernel

So _after_ the 1st kernel and _before_ the second kernel. It is an application
for the 1st kernel, which creates a tiny boot loader for 2nd kernel. After the
1st kernel is loaded, kexec-tools is executed in user space, which provides a
sane 2nd kernel and initramfs to the kernel using kexec() system call. Now 1st
kernel keep these information loaded into a specific memory called "Crash
Kernel" memory. When 1st kernel crashes, kernel kexec code passes control to
kexec boot loader, which does sha verification of 2nd kernel and initramfs and
passes control to 2nd kernel.

> and its modules are loaded (assuming modules are loaded from initramfs).
> If kexec-tools can somehow ping the watchdog (presumably by writing into
> the HW directly), I don't understand why it doesn't simply load the watchdog
> driver instead and let the watchdog core handle the heartbeats.

Because that tiny boot loader (which called purgatory) does not have any
knowledge about driver.

> 
> I am really missing something here. How can kexec-tools do anything before
> the kernel is loaded ?

So, if we _do_  _not_ go with the current version of patch, probably this could
be the only available option. However, Even when we would kick watchdog once in
kexec boot loader, we will have to make sure the 2nd kernel is light enough to
load watchdog module before timeout.  I think, in the long run we must have SBSA
watchdog specification improvement to keep WOR as 64 bit.

~Pratyush
