Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45393 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbcEEQnO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 May 2016 12:43:14 -0400
Date: Thu, 5 May 2016 09:43:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: Pratyush Anand <panand@redhat.com>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160505164300.GA16914@roeck-us.net>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com>
 <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com>
 <572A2099.4070901@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572A2099.4070901@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 04, 2016 at 11:17:29AM -0500, Timur Tabi wrote:
> Pratyush Anand wrote:
> >Its unique to SBSA because you have very little timeout here. kexec-tools
> >upstream does not have any mechanism to handle watchdog timeout. Lets say even
> >if we implement a framework there, the best it can do is to ping the watchdog
> >again.
> 
> Ok, so it's more accurate to say that kexec has a minimum watchdog timeout
> requirement.  What happens if the system admin sets the timeout to 5 seconds
> arbitrarily?  The system will reset during kexec, no matter which hardware
> is used.
> 
> This still sounds like a band-aid to me.  We're just assuming that we need a
> timeout of at least 20 seconds to support kexec.  Frankly, this still sounds
> like a problem the kexec developers needs to acknowledge and deal with.
> 
> Still I'm okay with a patch that extends the timeout by programming WCV, but
> it has to be commented as a hack specifically to support kexec because the
> timeout might be too short.  Then Wim can decide whether he supports such
> changes.
> 
I don't even understand how kexec-tools is involved in the first place.
kexec-tools sounds like user space, which should execute _after_ the kernel
and its modules are loaded (assuming modules are loaded from initramfs).
If kexec-tools can somehow ping the watchdog (presumably by writing into
the HW directly), I don't understand why it doesn't simply load the watchdog
driver instead and let the watchdog core handle the heartbeats.

I am really missing something here. How can kexec-tools do anything before
the kernel is loaded ?

Guenter
