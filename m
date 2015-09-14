Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbINEVK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Sep 2015 00:21:10 -0400
Date: Mon, 14 Sep 2015 09:51:04 +0530
From: Pratyush Anand <panand@redhat.com>
To: Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150914042104.GA4682@localhost.localdomain>
References: <=fu.wei@linaro.org>
 <1433217907-928-1-git-send-email-fu.wei@linaro.org>
 <1433217907-928-6-git-send-email-fu.wei@linaro.org>
 <556F4489.6030206@codeaurora.org>
 <20150603182503.GD6460@roeck-us.net>
 <556F4D29.1080001@codeaurora.org>
 <55F207FD.2030007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F207FD.2030007@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/09/2015:06:45:17 PM, Jon Masters wrote:
> On 06/03/2015 02:53 PM, Timur Tabi wrote:
> > On 06/03/2015 01:25 PM, Guenter Roeck wrote:
> >> In general the idea here would be to use a crashdump kernel, which,
> >> when loaded, would reset the watchdog before it fires. This kernel
> >> would then write a core dump to a specified location.

And this is what we do in fedora or RHEL. There had been some work ongoing in
fedora [1][2] which will help to reset any active watchdog in kdump kernel(if
the watchdog driver has been registered to watchdog_class). It will eventually
help a watchdog on ARM64 platform as well.

[1] https://lists.fedoraproject.org/pipermail/kexec/2015-September/002295.html
[2] https://github.com/pratyushanand/kexec-tools/commits/watchdog_fmaster

~Pratyush
