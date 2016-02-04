Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
To: Will Deacon <will.deacon@arm.com>, fu.wei@linaro.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, wim@iguana.be,
 linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com,
 Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, rruigrok@codeaurora.org, harba@codeaurora.org,
 cov@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
 graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org,
 jcm@redhat.com, arnd@arndb.de, leo.duran@amd.com, sudeep.holla@arm.com
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <20160204163101.GH17257@arm.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B37E52.300@codeaurora.org>
Date: Thu, 4 Feb 2016 10:37:38 -0600
MIME-Version: 1.0
In-Reply-To: <20160204163101.GH17257@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Will Deacon wrote:
>> +static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>> >+{
>> >+	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> >+
>> >+	/*
>> >+	* Writing WRR for an explicit watchdog refresh.
>> >+	* You can write anyting(like 0xc0ffee).
>> >+	*/
>> >+	writel(0xc0ffee, gwdt->refresh_base + SBSA_GWDT_WRR);
>> >+
>> >+	return 0;
>> >+}
> You might get in trouble for that. 0xd09f00d is probably less poisonous.
>
> http://www.petpoisonhelpline.com/poison/caffeine/

Any reason why we can't just keep it simple and write 0?
