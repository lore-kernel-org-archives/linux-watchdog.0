Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
To: Guenter Roeck <linux@roeck-us.net>, Fu Wei <fu.wei@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=c5=82_Moll?=
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>,
 Jon Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
 Christopher Covington <cov@codeaurora.org>, Dave Young <dyoung@redhat.com>,
 Pratyush Anand <panand@redhat.com>, G Gregory <graeme.gregory@linaro.org>,
 Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>,
 Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Leo Duran <leo.duran@amd.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B35698.4020100@codeaurora.org>
Date: Thu, 4 Feb 2016 07:48:08 -0600
MIME-Version: 1.0
In-Reply-To: <56B2DEE4.7060901@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote:
> Also, if panic is enabled, the timeout needs to be adjusted accordingly
> (to only panic after the entire timeout period has expired, not after
> half of it). We can not panic the system after timeout / 2.

It's a debugging feature, not an actual watchdog timeout panic.  That's 
why it's disabled by default.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
