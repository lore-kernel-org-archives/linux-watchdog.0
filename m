Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:37024
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932549AbdCUMsX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 21 Mar 2017 08:48:23 -0400
Date: Tue, 21 Mar 2017 05:48:13 -0700
From: "Lurndal, Scott" <Scott.Lurndal@cavium.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Timur Tabi <timur@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Len Brown <lenb@kernel.org>,
        "Abdulhamid, Harb" <harba@codeaurora.org>,
        Julien Grall <julien.grall@arm.com>,
        linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jon Masters <jcm@redhat.com>,
        Christopher Covington <cov@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v21 13/13] acpi/arm64: Add SBSA Generic
 Watchdog support in GTDT driver
Message-ID: <20170321124813.GB31496@slurndal-lnx1.caveonetworks.com>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej>
 <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
 <20170320180949.GM31213@leverpostej>
 <20170320185002.GT31496@slurndal-lnx1.caveonetworks.com>
 <CADyBb7vgzLCoFO6p=mu=D93VSHwuFh6cLEwVD9PvvuOUGxEgcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7vgzLCoFO6p=mu=D93VSHwuFh6cLEwVD9PvvuOUGxEgcw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 21, 2017 at 11:48:02AM +0800, Fu Wei wrote:
> Hi Mark, Lurndal,
> 
> >>       The base server system implements _a_ Generic Watchdog as
> >>       specified in APPENDIX A: Generic Watchdog.
> >
> >   It is a requirement of a conforming implementation that there
> > be a generic watchdog (impl as per the appendix).   That doesn't preclude
> > an implmentation from providing additional watchdogs (for example, if
> > the processor implements EL3, it is likely that an implementation
> > will include a secure watchdog as well as a non-secure watchdog).
> >
> >   The SBSA describes the minimal hardware requirements for a
> > compliant server.
> 
> So I think, for the SBSA watchdog:
> 
> (1) there maybe more then one non-secure watchdog in GTDT

I suppose a firmware vendor could chose to expose more than the
platform minimum to linux.   Not quite sure what linux would
do with it :-)

> 
> (2) we may also need to skip  secure watchdogs in GTDT,
> and only register non-secure watchdogs into platform resources.

The secure watchdog will, be definition, never be accessible
to non-secure EL2 or non-secure EL1, so only in the case of
a secure EL1 operating system would the secure watchdog ever
be conveyed through ACPI.   I don't think secure EL1 is in
the scope of the SBSA, or something that needs to be accomodated
in the GTDT at this time.

scott
