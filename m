Return-path: <panand@redhat.com>
Date: Tue, 15 Sep 2015 15:14:43 +0530
From: Pratyush Anand <panand@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
        linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
        graeme.gregory@linaro.org, al.stone@linaro.org, arnd@arndb.de,
        linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be,
        jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v7 2/8] ARM64: add SBSA Generic Watchdog device node in
 foundation-v8.dts
Message-ID: <20150915094443.GA3296@dhcppc13.redhat.com>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
 <1440435683-7343-3-git-send-email-fu.wei@linaro.org>
 <20150915084332.GC5767@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150915084332.GC5767@localhost.localdomain>
List-ID: <linux-watchdog@vger.kernel.org>

On 15/09/2015:04:43:32 PM, Dave Young wrote:
> On 08/25/15 at 01:01am, fu.wei@linaro.org wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> > 
> > This can be a example of adding SBSA Generic Watchdog device node
> > into some dts files for the Soc which contains SBSA Generic Watchdog.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
> > ---
> >  arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
> > index 4eac8dc..824431f 100644
> > --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
> > +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
> > @@ -237,4 +237,11 @@
> >  			};
> >  		};
> >  	};
> > +	watchdog@2a440000 {
> > +		compatible = "arm,sbsa-gwdt";
> > +		reg = <0x0 0x2a440000 0 0x1000>,
> > +			<0x0 0x2a450000 0 0x1000>;
> > +		interrupts = <0 27 4>;
> > +		timeout-sec = <10 5>;
> 
> I assume 10 is timeout, 5 is pre timeout, but in the driver code the default
> value is 30/10, I think the example dts[i] should use same default values as in code.
> 
> BTW, for kdump kernel Pratyush is working on kdump on wdt enabled system. 
> Basiclly we expect one configure longer timeout, and kick it in shorter
> period so we can get a chance to save vmcore. 10s sounds too short for the case..

Specially if D-cache is not enabled in ARM64 kexec-tool/purgatory then its more
than 2 min. Geoff has yet not agreed [1] to take D-cache support in purgatory.

[1] https://www.mail-archive.com/kexec@lists.infradead.org/msg12881.html

~Pratyush
