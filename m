Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C05111A8;
	Tue,  8 Sep 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890333; cv=none; b=mVG8oSHzT9bFTc53Gk8T1llAQrnlRE8ZVscgGQWwoH9yPdwZsd3JnRXsRzv1FJKFMHvDcSgUrTaD2z84nEZXSLOl0j7f0VI9HUg5hlNQJz5jPSPm4an91joLDBNlHtrvSYgqCSdRsRvkOSc+naedsqy2aEg7wfiuw5lfItz1K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890333; c=relaxed/simple;
	bh=fI7oVrJGmODkETK21KExKt5SM6XwZY5nsoSFNHo7lvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=czmVH4Hv9svvKOLH15869t1TF+xuDp7MycEnY/ygVSUJ+yel0C/Ue1AvpMgH9V4k7co7w5CUiMgPaeNz51TeillKBvwDmCo9BNMrF2e+Da7jj5FkvTe5T7ujFCM0IdID+UMVOaCUw++XRRzzG5RvXnYxKlAw8PhMQnqJKQ8le7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoqHgkTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoqHgkTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5C1F00A3A;
	Tue,  8 Sep 2026 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890331;
	bh=Nd9vL7366quzXSzytNP0ezSXovdi1blO+h9i8j1gkmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoqHgkTTBSHbIYMYbCeEx73x7pMToPdK+JYc0+zG/hbTO5Dg2iyXHRdrE43wTnwLu
	 C3u4lijzcfMhH4fcLH+4sHcq5YwOncs6go57K+pF7RgTbmMkyWuXxXcvpTqdphOEmi
	 sC5hwiSFxnk4o91NppKuIc3KeNftKwZZsgJ97Ba6GOUCTeVSJK++TF/jhkBVV4UXt8
	 xLfCmxfInHTD8886plvyNOnv1wDarlT1cVm2QmTT8CKMguDO4VYIeqEv9fknU0yVhO
	 sX5tTjumNo03lOXjRmTUaB+TkrSnFcO7twAWYN6U4+SiYc9ZDpZ5r43+ynDeNDh594
	 gy5q5s10L/vJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] dt-bindings: reset: Add mmsys reset ids for
 mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260908174259.9009-7-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-7-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:58:50 +0000
Message-Id: <20260908175851.5BE5C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The mt8167-mmsys reset provider capability is introduced without=
 updating the YAML binding to require #reset-cells.
--

commit 58d3f60477024bb27299c071d1ec1f38c92deeac
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: dt-bindings: reset: Add mmsys reset ids for mt8167

According to the SoC data sheet, the mt8167 has 28 mmsys resets. This commit
adds the corresponding IDs that can be used in device trees to identify
subsystem resets.

> diff --git a/include/dt-bindings/reset/mediatek,mt8167-mmsys.h b/include/=
dt-bindings/reset/mediatek,mt8167-mmsys.h
> new file mode 100644
> index 0000000000000..b21f67b3b55c7
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt8167-mmsys.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT8167_MMSYS_H_
> +#define _DT_BINDINGS_RESET_MEDIATEK_MT8167_MMSYS_H_
> +
> +/* MMSYS reset IDs */
> +#define MT8167_MMSYS_SW0_RST_B_SMI_COMMON	0

[Severity: Medium]
This commit introduces a new reset provider capability by adding reset IDs
for mt8167-mmsys, but should the corresponding YAML binding be updated as
well?

Looking at Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya=
ml,
when hardware gains new provider capabilities like resets, the standard
properties such as #reset-cells must be added to the required list or a
compatible string-specific conditional block.

Without this update, a device tree node using mediatek,mt8167-mmsys could
omit the #reset-cells property and still pass dtbs_check schema validation.

This allows incomplete device trees to slip through, potentially causing
runtime failures for reset consumers.

Should the mediatek,mmsys.yaml binding be updated to enforce #reset-cells
for this compatible string?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174259.9009=
-1-l.scorcia@gmail.com?part=3D6
