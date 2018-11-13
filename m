Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45258 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbeKMR0c (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Nov 2018 12:26:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so12014036wre.12
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Nov 2018 23:29:42 -0800 (PST)
Date: Tue, 13 Nov 2018 07:29:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181113072938.GB29388@dell>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540830122-2577-2-git-send-email-p.paillet@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 29 Oct 2018, Pascal PAILLET-LME wrote:

> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10

Nit: "STPMIC1 is a PMIC".

Once corrected, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
