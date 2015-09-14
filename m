Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:36248 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358AbbINIvl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Sep 2015 04:51:41 -0400
Date: Mon, 14 Sep 2015 09:51:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jon Masters <jcm@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, will.deacon@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150914085137.GB22991@e104818-lin.cambridge.arm.com>
References: <=fu.wei@linaro.org>
 <1433217907-928-1-git-send-email-fu.wei@linaro.org>
 <1433217907-928-6-git-send-email-fu.wei@linaro.org>
 <556F4489.6030206@codeaurora.org>
 <20150603182503.GD6460@roeck-us.net>
 <556F4D29.1080001@codeaurora.org>
 <55F207FD.2030007@redhat.com>
MIME-Version: 1.0
In-Reply-To: <55F207FD.2030007@redhat.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 10, 2015 at 06:45:17PM -0400, Jon Masters wrote:
> On 06/03/2015 02:53 PM, Timur Tabi wrote:
> > On 06/03/2015 01:25 PM, Guenter Roeck wrote:
> >> In general the idea here would be to use a crashdump kernel, which,
> >> when loaded, would reset the watchdog before it fires. This kernel
> >> would then write a core dump to a specified location.
> > 
> > What is the mechanism for resetting the watchdog?  The only code that 
> > knows about the hardware registers is this driver.  Does the crashdump 
> > kernel call the watchdog stop function?
> > 
> >> If arm64 doesn't support a crashdump kernel, it might still be possible
> >> to log the backtrace somewhere (eg in nvram using pstore if that is
> >> supported via acpi or efi).
> 
> Just to go back and explicitly answer this, arm64 does have support for
> crashdump, using the standard kexec/kdump approach, exactly as on x86.

Just a clarification - this is not (yet) supported in mainline, not even
with DT.

-- 
Catalin

