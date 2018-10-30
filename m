Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38425 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJ3WLC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 Oct 2018 18:11:02 -0400
Subject: Re: [PATCH v5 7/8] dt-bindings: watchdog: document stpmic1 pmic
 watchdog
To: Pascal PAILLET-LME <p.paillet@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-8-git-send-email-p.paillet@st.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e74f50d1-0508-a7b1-7352-2d8eb867ee3b@roeck-us.net>
Date: Tue, 30 Oct 2018 06:17:35 -0700
MIME-Version: 1.0
In-Reply-To: <1540830122-2577-8-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/29/18 9:22 AM, Pascal PAILLET-LME wrote:
> The stpmic1 PMIC embeds a watchdog which is disabled by default.
> In case of watchdog, the PMIC goes off.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> changes in v5: nothing
> 
>   Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt b/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> new file mode 100644
> index 0000000..7cc1407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> @@ -0,0 +1,11 @@
> +STMicroelectronics STPMIC1 Watchdog
> +
> +Required properties:
> +
> +- compatible : should be "st,stpmic1-wdt"
> +
> +Example:
> +
> +watchdog {
> +	compatible = "st,stpmic1-wdt";
> +};
> 
