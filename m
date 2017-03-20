Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:59584
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755240AbdCTSuK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 14:50:10 -0400
Date: Mon, 20 Mar 2017 11:50:02 -0700
From: "Lurndal, Scott" <Scott.Lurndal@cavium.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Fu Wei <fu.wei@linaro.org>,
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
Message-ID: <20170320185002.GT31496@slurndal-lnx1.caveonetworks.com>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej>
 <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
 <20170320180949.GM31213@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320180949.GM31213@leverpostej>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 20, 2017 at 06:09:50PM +0000, Mark Rutland wrote:
> On Tue, Mar 21, 2017 at 01:57:58AM +0800, Fu Wei wrote:
> > On 18 March 2017 at 04:01, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei@linaro.org wrote:
> 
> > > I've not been able to find where the ACPI spec says that zero is not a
> > > valid GSIV. This may simply be an oversight/ambiguity in the spec.
> > >
> > > Is there any statement to that effect?
> > 
> > you are right, zero is a  valid GSIV, I will delete this check. Thanks
> 
> That being the case, how does one describe a watchdog that does not have
> an interrupt?
> 
> As I mentioned, I think this is an oversight/ambiguity in the spec tat
> we should address.
> 
> > > My reading of SBSA is that there is one watchdog in the system.
> > >
> > > Is that not the case?
> > 
> > do you mean:
> > ---------------
> > 4.2.4 Watchdogs
> > The base server system implements a Generic Watchdog as specified in
> > APPENDIX A: Generic Watchdog.
> > ---------------
> > 
> > I am not sure about that if this is saying "we only have one SBSA
> > watchdog in a system"
> > 
> > would you let me know where mention it? Do I miss something?
> 
> My reading was that the 'a' above meant a single element. i.e.
> 
> 	The base server system implements _a_ Generic Watchdog as
> 	specified in APPENDIX A: Generic Watchdog.

  It is a requirement of a conforming implementation that there
be a generic watchdog (impl as per the appendix).   That doesn't preclude
an implmentation from providing additional watchdogs (for example, if
the processor implements EL3, it is likely that an implementation
will include a secure watchdog as well as a non-secure watchdog).

  The SBSA describes the minimal hardware requirements for a
compliant server.

scott
