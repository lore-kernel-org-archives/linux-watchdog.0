Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59662 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbbH0NlW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Aug 2015 09:41:22 -0400
Date: Thu, 27 Aug 2015 15:40:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Hanjun Guo <hanjun.guo@linaro.org>
cc: Fu Wei <fu.wei@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com,
	panand@redhat.com, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 8/8] clocksource: simplify ACPI code in
 arm_arch_timer.c
In-Reply-To: <55DF1257.9090303@linaro.org>
Message-ID: <alpine.DEB.2.11.1508271539560.15006@nanos>
References: <=fu.wei@linaro.org> <1440435683-7343-1-git-send-email-fu.wei@linaro.org> <1440435683-7343-9-git-send-email-fu.wei@linaro.org> <alpine.DEB.2.11.1508241942450.3873@nanos> <CADyBb7sVGePKtU45_DBGd74fykAPVshmbnRQJDDOrrvoHTGcKQ@mail.gmail.com>
 <alpine.DEB.2.11.1508252113590.15006@nanos> <55DEFC54.4090904@linaro.org> <alpine.DEB.2.11.1508271405330.15006@nanos> <55DF025F.2050102@linaro.org> <55DF1257.9090303@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 27 Aug 2015, Hanjun Guo wrote:
> > [1]: https://lkml.org/lkml/2015/7/29/236
> > 
> > If that is ok with you, we will introduce similar DECLARE_ thing
> > for clock declare.

Yes.
 
> Or we can drop this patch from this patch set, and clean up this
> patch when the ACPI_DECLARE() infrastructure is ready for upstream.

Works either way. I just noticed that hard coded init thing and
decided to rant about it :)

Thanks,

	tglx
