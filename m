Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbcLGRZf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Dec 2016 12:25:35 -0500
MIME-Version: 1.0
In-Reply-To: <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
References: <20161125084623.22515-9-fu.wei@linaro.org> <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Date: Wed, 7 Dec 2016 11:25:31 -0600
Message-ID: <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v17 08/15] clocksource/drivers/arm_arch_timer:
 move arch_timer_needs_of_probing into DT init call
To: Fu Wei <fu.wei@linaro.org>
Cc: kbuild test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Timur Tabi <timur@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, kbuild-all@01.org,
        "Abdulhamid, Harb" <harba@codeaurora.org>,
        Julien Grall <julien.grall@arm.com>,
        linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jon Masters <jcm@redhat.com>,
        Christopher Covington <cov@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Len Brown <lenb@kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei@linaro.org> wrote:
>
> a "+ int ret;" should be move from [12/15] to here, I have fix the
> problem in my repo, it would happen in next patchset
>
> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel

Fu, please post v18 to the mailing list so that it can be picked up
for 4.10 (if it's not too late already).

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
