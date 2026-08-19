Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43A3C13EF
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159893; cv=none; b=BlnaEzVmmISlIFh0klrjOHvoh1wXjO9Ca0RIOjCtMGaXB5pP9kfZSDF5iJo0k5vB6Yw2WqYq5yzI/g8qws7rxCHSYoQEpg1ftsQLHbJdh6GfiJYTJ6gm4Yv4tZ+rZuKB+WCan3KCN01G8NFNRg1zu3OGd1j/yA6AG6arKcRcfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159893; c=relaxed/simple;
	bh=NzDJxIEnmWSoEW/CSHKna408GEw1PamOuVwZswoR4H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8Zp7lIIw+mihx23Eky8/mxumyeWp66WD0llZdHf57momC7Iz2Y59Z6HM7H3kxp0+f1B/+CXKHf5CMIO1MN/mpc4Q45pJmvitY5XX2h7jBmythd40gcqvnHnsgAODIgnlmb9nr5LonNVQ2SN3pG+QkPTrOdJWPW6+bvI3kAkdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsSkZDwq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsSkZDwq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1833087a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787159871; x=1787764671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VFRNQn9+IiCFEpwSAiKoW4qdoRMCAiZZVu4dsGCqCeM=;
        b=RsSkZDwqzw3yGczzFUVb+3Jtb02whf9tbqEh7CakATe7V7IBjaCmLtS74+3Gb56opu
         sM99/cRhjyyqfdjnPqHjiYeOCFH/PCD9t67F9z5ranKnBcH2PmD9LjoljRw5ZJCbzTs7
         BztMnb6THylEyZfFxV+3gc6R20a0WE9chiaxoHDGAs1XVEO17+BizD3lR3Fubsh+kokM
         KGpf3I+YKubjcEqDYTplwh4McPe6IJEbD2jl11rdhrt9ZeBM1mzLyTVcFLy7UiaG/shJ
         oqacjti6RiF29WKpkQCAUlr7qq/5/Is3qJRpHlHn8czLq1Q7wFhIKaNkAI5NMz2oj0Yr
         4jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159871; x=1787764671;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFRNQn9+IiCFEpwSAiKoW4qdoRMCAiZZVu4dsGCqCeM=;
        b=KU7OgW/jcXtJH1IUkb1xbpjCs96RDq8TcCGdYKjqTVfx2/yJvUbAbxskheJ8tUK7RW
         XVwp1jLJND0ZWVLIYkpns4mQRWozJ1QstC5B27HCZrzrKeRx4cifW4adMfcmp5T4037B
         Myo6mc4AEXjaje+hAekLJBOZcf7W9wEcaNZedYVil/HGnhY3vCk5EKQ8Y3UFBcBU1pl2
         rCN5TYyhDVdkUKhVW/Qultv+Y0ZqFKCQZmU61pEKoWXpL4/rtE2E57RcPVq2D9sXrsU0
         4j3+4Ry/zAkHtFGnXYXZR+OU6aprjPV1/g7ZLtWo0q4i9m9JRkbECpBoq7mgmbH9TT0/
         gzEw==
X-Forwarded-Encrypted: i=1; AHgh+RoAjY7rdFsZERRPWmmxVp51TP0idSARo7x0qaqrx27jjJOPy6rFwoPFn9gxlBVMiu03U5a3LsIQjyoGgkrgKA==@vger.kernel.org
X-Gm-Message-State: AFuF++mXCRtXfxTdElEF0+Z6GZLZ1JalpwVHygR/UnsNoM7BP5HwmXPy
	7UAL5zEGyxPpM81Yq0qsB063xW5lpjC06IiJ0941BzttMEHRhnt46LKi
X-Gm-Gg: AR+sD10HCCoweCNW7emRO5dCgxsK6lBa31/yt3+R4BeNXc50CnPwxiTm0FJD+vqusw9
	3kraiIWHi5tb2Hg5Hf3Ibit1EAbEpwvGlKkn6jyVwTdjTUq2b3OW5Rrl5e17HSNM6psmAve4QNG
	WaRMBOjOtADBQnq2LxX1Y8xLqx0lxuBA4vXyfV+ivvfyYQRaz5Y4Ds2JjpwcbU0gasTqHONGqAX
	PjNuxuekYiJayC9h8hNOtz4I2WvMi7matdZMMV5QIWFqOtW4GFDXJm8RlyrpTQsGFy9iq+DTy0T
	N54o6/XBv9L+wvDqBJO3IbIs1juqAh8DyEsnoJ9hgNZ9HENbfEx3FGx+Mjklq07CXQebcmdTA5J
	OxEjUQWit+arzuZ/DUHFr56DfRQV5kYkzsLMUVpyMr0HM4iB2Nev1ozHosluwbEgP3bPM/ZQ1uV
	RG7Obi554rVT8Ceak4diK1gvjTcbFurIi9Yoefa6ryWzI6b2/HQwtforWypRTenM67KIHaRZwTW
	/x6YZVm71VIFjpHqN7J
X-Received: by 2002:a17:90a:e188:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-39580a50d5cmr11805598a91.3.1787159870492;
        Wed, 19 Aug 2026 10:17:50 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f4cedeesm1482992a91.0.2026.08.19.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:17:50 -0700 (PDT)
Date: Thu, 20 Aug 2026 02:17:46 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Properly describe mt6589 and mt8167 toprgu resets
Message-ID: <xqnpukvhtezpqhwjnxbqeddiaqlro4m5yjukpplv5mjfxodlfp@ijaf2trst7p4>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819101853.44681-1-l.scorcia@gmail.com>

Hi Luca,

On Wed, Aug 19, 2026 at 12:16:21PM +0200, Luca Leonardo Scorcia wrote:
> Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
> which in turn falls back on mt6589-wdt, which does not support toprgu
> resets yet. This series adds support for mt6589 toprgu resets with bit
> definitions obtained from Android stock sources.
> 
> However, according to its data sheet, mt8167 has 14 sw resets instead of
> 12, and the reset bits are non-contiguous. This is currently unsupported
> by the mtk-wtd driver, and it caused confusion between reset IDs and reset
> bits in device tree includes.
> 
> Therefore in the first three patches we improve the description of the,
> resets for mt6589 using the definitions obtained from Android sources.
> 
> Then we introduce a dedicated mediatek,mt8167-wdt compatible for the
> watchdog driver that describes correctly this SoC's resets. Also while
> we're touching the bindings reset includes, we add IDs for the MMSYS
> resets.

This is somewhat outside the scope of this series, but adding TOPRGU
reset support for MT6589 exposes a pre-existing problem with the
mtk-wdt binding that I think should not go unnoticed.

Until now, using `mediatek,mt6589-wdt` as a fallback compatible for
other SoCs was mostly harmless, since the driver did not expose the
TOPRGU reset controller.
This series changes that by adding reset controller support for MT6589.

According to the MT6589 datasheet, its TOPRGU reset bits are:

  0 infra
  1 disp (same as mmsys in upstream)
  2 mfg
  3 venc
  4 vdec
  5 img
  6 ddrphy
  7 md
  8 infra_ao
  9 md_lite
 10 apmixed
 11 pwrap_spictl

These are the reset bits that `mediatek,mt6589-wdt` will provide once
this series is merged.
Therefore, for another SoC to use this compatible as a fallback,
its TOPRGU reset layout needs to be compatible with the above.

At commit bd5f485f3f02, mediatek,mtk-wdt.yaml contains:

      - items:
          - enum:
              - mediatek,mt2701-wdt
              - mediatek,mt6572-wdt
              - mediatek,mt6582-wdt
              - mediatek,mt6797-wdt
              - mediatek,mt7622-wdt
              - mediatek,mt7623-wdt
              - mediatek,mt7629-wdt
              - mediatek,mt8173-wdt
              - mediatek,mt8188-wdt
              - mediatek,mt8189-wdt
              - mediatek,mt8365-wdt
              - mediatek,mt8516-wdt
          - const: mediatek,mt6589-wdt

Let's examine the evidence for each of these SoCs.

## MT2701

I could not find enough public information to determine the reset
layout.


## MT6572

A downstream kernel suggests it has the same reset layout as MT6589:
https://github.com/orangepi-xunlong/OrangePi3G-iot_external/blob/b8a66e9bde91d75a8535dc6342d668efb6ab14ee/mediatek/platform/mt6572/kernel/core/include/mach/mt_wdt.h

However, a report based on actual hardware suggests
it may have fewer resets than MT6589:
https://lore.kernel.org/linux-mediatek/W7fWZU3pu6akI_HMTAWPGnnErv60QtTz-LaPb6OtGvU5Bx0Iekl4SxWB6mxBPx8cBo9q9Lg7t8dDzcyfti-5fTirEACcwCLhNAh8e5xoHus=@protonmail.com/

The datasheet is missing the bitfield for WDT_SWRST. 


## MT6582

According to the datasheet, the reset bits are:

  0 infra
  1 mm
  2 mfg
  4 vdec
  5 venc
  6 ddrphy
  7 md
  8 infra_ao
  9 conn
 10 apmixed
 12 conn_mcu

This is clearly not the same reset layout as MT6589.


## MT6797

According to the downstream kernel,
it has additional resets compared to MT6589:

  #define MTK_WDT_SWSYS_RST_C2KSYS_RST    (0x10000)
  #define MTK_WDT_SWSYS_RST_C2KWDT_RST    (0x20000)
  #define MTK_WDT_SWSYS_RST_CONMCU_RST    (0x1000)

https://github.com/SHIFTPHONES/android_kernel_shift_mt6797/blob/4c594e5fa5648dd9a8b8ccc5d609bb523f4799b7/drivers/watchdog/mediatek/wdt/mt6797/mt_wdt.h


## MT7622

According to the datasheet, the reset bits are:

  0 infra
  1 ethdma
  6 ddrphy
  8 infra_ao
  9 conn
 10 apmixed
 12 conn_mcu

This is not the MT6589 reset layout.


## MT7623

According to the datasheet, the reset bits are:

  0 infra
  1 mm
  2 mfg
  3 ethdma
  4 vdec
  5 venc_img
  6 ddrphy
  7 md
  8 infra_ao
  9 conn
 10 apmixed
 11 hifsys
 12 conn_mcu
 13 bdp_disp

Again, this is not the MT6589 reset layout.


## MT7629

I have no evidence either way. 


## MT8173

A the downstream kernel claims that MT8173 is compatible
with MT2701, MT8127 and MT8163:
https://github.com/bq/aquaris-M10/blob/ab0f5a519edaf314e9b537e448838ec9a4a9a3c8/drivers/watchdog/mediatek/wdt/common/mtk_wdt.c

I don't find this particularly convincing.

MT8163 has 15 reset bits:
https://github.com/amazon-oss/android_kernel_amazon_mt8163/blob/479f405abf2ee6c0f13688b8cf567cce135924af/include/dt-bindings/reset-controller/mt8163-resets.h

MT8127 appears to have the same reset layout as MT6589:
https://github.com/amazon-oss/android_kernel_amazon_mt8127/blob/8428ef2958b83fa51edd6de734c069455f00cd8b/arch/arm/mach-mt8127/include/mach/mt_wdt.h

However, I am not sure whether this actually reflects the hardware.


## MT8188

This is presumably a typo for MT8189, because there is no explanation
for using MT8188 in the patch:


[PATCH v7 6/9] dt-bindings: watchdog: Support MediaTek MT8189 wdt

modify dt-binding for support mt8189 dts node of wdt

Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---
Changs in v7:
 - update dt-bindings commit msg
   (use "mt8189" instead of "mt8189 evb board")

---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index ba0bfd73ab62..a05f8155b738 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -41,6 +41,7 @@ properties:
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
               - mediatek,mt8173-wdt
+              - mediatek,mt8188-wdt
               - mediatek,mt8365-wdt
               - mediatek,mt8516-wdt
           - const: mediatek,mt6589-wdt
-- 
2.45.2


https://lore.kernel.org/linux-arm-kernel/20251111070031.305281-7-jh.hsu@mediatek.com/
https://github.com/torvalds/linux/commit/a742d1713c34dff992d1273f614548d214ba1550
I honestly cannot understand how this passed review.

MT8188 already had a standalone compatible entry before this patch,
and it is clearly not compatible with MT6589:
https://github.com/torvalds/linux/blob/bd5f485f3f026225b86573e559af0b7254ef4184/include/dt-bindings/reset/mt8188-resets.h


## MT8189

There is no publicly available information about its reset layout:
https://github.com/external-mirrors/chromiumos-third_party-kernel/blob/a5153266e4c8777fac687e9009a12d32d946514b/drivers/watchdog/mtk_wdt.c#L462


## MT8365

I have no evidence to establish compatibility.


## MT8516

According to the downstream kernel, its reset layout appears to be
compatible with MT6589:
https://android.googlesource.com/platform/hardware/bsp/kernel/mediatek/mt8516-v4.4/+/refs/heads/nougat-iot-release/drivers/watchdog/mediatek/wdt/common/mtk_wdt.h


Note that a downstream kernel claiming compatibility does not necessarily
mean that the SoCs are actually compatible. In my experience, MediaTek's
downstream kernels contain substantial amounts of copied code between
different SoCs, so I would not consider such compatibility claims
sufficient evidence on their own.

Overall, I don't think `mediatek,mt6589-wdt` is an appropriate fallback
compatible for most of the SoCs currently listed in the binding.
I realize that fixing all of these bindings is outside the scope of
this series, but I think this should be addressed rather than leaving
`mediatek,mt6589-wdt` as a generic fallback.


I also noticed that the v3 link is missing from the cover letter:
[3] https://lore.kernel.org/linux-arm-kernel/20260809160643.33991-1-l.scorcia@gmail.com/

Best regards,
Akari
