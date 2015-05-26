Return-path: <will.deacon@arm.com>
Date: Tue, 26 May 2015 13:28:58 +0100
From: Will Deacon <will.deacon@arm.com>
To: "fu.wei@linaro.org" <fu.wei@linaro.org>
Cc: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tekkamanninja@gmail.com" <tekkamanninja@gmail.com>,
	"graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
	"al.stone@linaro.org" <al.stone@linaro.org>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>,
	"ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"vgandhi@codeaurora.org" <vgandhi@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>, "jcm@redhat.com" <jcm@redhat.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH v3 6/6] ACPI: import watchdog info of GTDT into platform
 device
Message-ID: <20150526122858.GJ1565@arm.com>
References: <=fu.wei@linaro.org>
 <1432548193-19569-1-git-send-email-fu.wei@linaro.org>
 <1432548193-19569-7-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432548193-19569-7-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, May 25, 2015 at 11:03:13AM +0100, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
> and create a platform device with that information.
> This platform device can be used by the ARM SBSA Generic
> Watchdog driver.
> 
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)

Why does this all need to be under arch/arm64? The GTDT really isn't
architecture-specific, so I'd *much* rather it was parsed in the driver code
itself, like we already do for the architected timer. The GIC is an
exception because it's in the MADT, which we need to parse in the arch code
to configure SMP properly.

Will
