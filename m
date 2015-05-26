Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56925 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbEZSYJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 14:24:09 -0400
Date: Tue, 26 May 2015 11:24:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, ashwin.chaugule@linaro.org, arnd@arndb.de,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v3 6/6] ACPI: import watchdog info of GTDT into platform
 device
Message-ID: <20150526182403.GA23370@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432548193-19569-1-git-send-email-fu.wei@linaro.org>
 <1432548193-19569-7-git-send-email-fu.wei@linaro.org>
 <55642EA8.5000003@linaro.org>
 <5564A0C7.1090306@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5564A0C7.1090306@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 26, 2015 at 11:35:19AM -0500, Timur Tabi wrote:
> On 05/26/2015 03:28 AM, Hanjun Guo wrote:
> 
> >>      early_acpi_os_unmap_memory((char *)table, tbl_size);
> >>  }
> >
> >please add
> >
> >#ifdef CONFIG_ARM_SBSA_WATCHDOG
> >(acpi gtdt code)
> >#endif
> 
> I don't agree with this.  The GTDT should be parsed even if there's no
> watchdog driver compiled for this kernel.  There are no other #ifdefs in
> this file.
> 

Me not either, but then I thought this is really a maintainer question.
If the maintainers want out-of-subsystem #ifdefs in the code, who am I
to complain.

Should be "#if IS_ENABLED(CONFIG_ARM_SBSA_WATCHDOG)", though, if we go
along that route.

Guenter
