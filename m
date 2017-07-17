Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Mon, 17 Jul 2017 13:50:51 -0500
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: lee.jones@linaro.org, mark.rutland@arm.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, wim@iguana.be,
	linux@roeck-us.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-binding: mfd: Add Maxim/Dallas DS1374 MFD device
 binding
Message-ID: <20170717185051.7yd5wdynyesc7lyy@rob-hp-laptop>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499975665-14581-1-git-send-email-mdf@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Jul 13, 2017 at 12:54:24PM -0700, Moritz Fischer wrote:
> This adds a binding for the Maxim/Dallas DS1374 MFD.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes from RFC:
> - dallas,ds1374-mode -> dallas,mode
> - Clarified examples
> - dallas,remap-reset property
> 
> On second thoughts the solution for the remapping found in the
> discussion did not seem to be a good solution, since the INT
> pin indicating watchdog reset does not necessarily have to be
> connected to an interrupt line on the machine, it could equally
> well be hooked up to a PMIC reset input or similar.
> In that case using the presence of an 'interrupt' phandle is not
> a good choice.
> 
> Cheers,
> 
> Moritz
> 
> ---
>  Documentation/devicetree/bindings/mfd/ds1374.txt   | 88 ++++++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.txt        |  1 -
>  drivers/rtc/Kconfig                                |  2 +

This belongs in patch 2. With that dropped,

Acked-by: Rob Herring <robh@kernel.org>

>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ds1374.txt
