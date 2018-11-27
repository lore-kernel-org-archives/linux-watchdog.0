Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Mon, 26 Nov 2018 19:49:35 -0600
From: Rob Herring <robh@kernel.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, andy.gross@linaro.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: watchdog: Add Qualcomm PM8916
 watchdog
Message-ID: <20181127014935.GA7099@bogus>
References: <1542962678-13697-1-git-send-email-loic.poulain@linaro.org>
 <1542962678-13697-2-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542962678-13697-2-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, 23 Nov 2018 09:44:37 +0100, Loic Poulain wrote:
> Document support for the Watchdog Timer (WDT) Controller in the
> Qualcomm PM8916 PMIC module.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: Add interrupts and timeout-sec props
>  v3: Reword props summary
> 
>  .../bindings/watchdog/qcom,pm8916-wdt.txt          | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
