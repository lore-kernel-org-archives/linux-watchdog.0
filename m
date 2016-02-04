Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
To: Mathieu Poirier <mathieu.poirier@linaro.org>, fu.wei@linaro.org
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=c5=82_Moll?=
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, wim@iguana.be, linux@roeck-us.net,
 Jon Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Suravee.Suthikulpanit@amd.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linaro-acpi@lists.linaro.org,
 rruigrok@codeaurora.org, harba@codeaurora.org,
 Christopher Covington <cov@codeaurora.org>, dyoung@redhat.com,
 panand@redhat.com, graeme.gregory@linaro.org, al.stone@linaro.org,
 hanjun.guo@linaro.org, jcm@redhat.com, Arnd Bergmann <arnd@arndb.de>,
 leo.duran@amd.com, Sudeep Holla <sudeep.holla@arm.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <CANLsYkyLBfSKFM6CCyPP+Eaua2B+n80wL2hnQVSvfUNMPd3OdQ@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B37FA0.5000209@codeaurora.org>
Date: Thu, 4 Feb 2016 10:43:12 -0600
MIME-Version: 1.0
In-Reply-To: <CANLsYkyLBfSKFM6CCyPP+Eaua2B+n80wL2hnQVSvfUNMPd3OdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Mathieu Poirier wrote:
>> >+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
>> >+       irq = platform_get_irq(pdev, 0);
>> >+       if (irq < 0) {
>> >+               dev_err(dev, "unable to get ws0 interrupt.\n");
>> >+               return irq;
>> >+       }
>> >+#endif
>> >+
> Can't the driver revert to single stage mode if platform_get_irq()
> fails?  That way the value of 'irq' can be tested throughout the
> _probe() function and the #ifdefs removed.

I like that idea.  The same can be done with the devm_request_irq() 
call.  It should definitely still display a warning if the command-line 
option is set but no interrupt is available.
