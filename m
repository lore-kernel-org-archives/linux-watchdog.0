Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C763FC5D3;
	Wed, 19 Aug 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135348; cv=none; b=RWPmKZ964NT6RiNZDDuEzAjx6aDdhXlS84Mn1aT8qG3seJNjJDEwIaTZHizubDpoVJRQLafbfj3mgfFr1mCJhqDAySGKE+lsH4R/V8gtzzytv4GRJT7QEZqCwZCSU7rdlkIAtphI/4L2XH2wzWcUmyq01805XOs9bV8aWdVXPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135348; c=relaxed/simple;
	bh=RQ6GtnhW6Q2nHKojH6ObJaJlGLZGCUs8hN5ryxpKvxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=msiqUGckbzWVy8PGJ3f6D+PosLG23bBT15E1cw0SFz9F3ELK5G9g0ZvlhABiQc7vnjDejx/xvAm34higLH8WEoyTgYL+YcXVotl9F26aarpR8UaQzZ7t1LdcEftVn9lV7nBeQWXlTTfcQnXGQPOtWfEWSkFt+mBBgPvh2TAwDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k42nkq1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k42nkq1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5028C1F000E9;
	Wed, 19 Aug 2026 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787135346;
	bh=ChixR8/H/LVv6FNfega/tFPJtJ8FPDgf30iYbPAMfwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k42nkq1ZNZrijNUivz/hfss16pQE4jkEMW0h5FwbcFHJhI0dzhlYGn3fRobdHUVbo
	 xqUt+uryjaUx+7yG/QniYig0oh8TYAQdGYwja1/SOufPZls749Yi0SNMD+0MDUwoqg
	 nAxWbUQ9kFkwdnIncFtvUKLFKKA01fIxdjb9Ahdrz19HmR5ZEpXbH4N3zIltO9d/Y8
	 XWVlaUNL0Qy1qw0GMCeLtApif7+ce12khR59GnM+gvuYVpWx6/pJYmlPIx3oWuDjbZ
	 4uubmrk0ieO14UtbeBE2WC7GChY2CEh33RrlmuPs0Tglm5m64d4jqbaAYq9RRrK4n7
	 YKb3AjEcjWzpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260819101853.44681-5-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
 <20260819101853.44681-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:29:05 +0000
Message-Id: <20260819102906.5028C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing `#reset-cells` required property constraint for the `med=
iatek,mt8167-wdt` reset provider capability.
- [Medium] Missing `#reset-cells` required property constraint for the `med=
iatek,mt8167-mmsys` reset provider capability.
--

--- Patch [4]: [PATCH v4 4/7] dt-bindings: watchdog: Add compatible for Med=
iaTek mt8167 ---
commit cda604d8e57545578970aa161f863c629cec7278
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: watchdog: Add compatible for MediaTek mt8167

This commit adds a dedicated compatible string for the MediaTek mt8167
watchdog. It also introduces two new header files defining reset IDs for
the toprgu (watchdog) and mmsys subsystems.

> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 953629cb9558b..f514be8a5851d 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt6795-wdt
>            - mediatek,mt7986-wdt
>            - mediatek,mt7988-wdt
> +          - mediatek,mt8167-wdt

[Severity: Medium]
Since this compatible string is being added as a reset provider (indicated =
by
the new mediatek,mt8167-wdt.h header), should #reset-cells be added as a
required property constraint for mediatek,mt8167-wdt?

Without this constraint, device tree nodes using the mediatek,mt8167-wdt
compatible string could silently pass validation even if they omit
#reset-cells. This would allow incomplete configurations to escape schema
verification, leading to downstream driver or probe failures when another n=
ode
attempts to reference it as a reset provider.

[ ... ]

> diff --git a/include/dt-bindings/reset/mediatek,mt8167-mmsys.h b/include/=
dt-bindings/reset/mediatek,mt8167-mmsys.h
> new file mode 100644
> index 0000000000000..b21f67b3b55c7
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt8167-mmsys.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT8167_MMSYS_H_

[Severity: Medium]
This new header introduces reset IDs for the mt8167-mmsys hardware, formally
making it a reset provider.

Does the Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
schema also need to be updated in this patch to require the #reset-cells
property for the mediatek,mt8167-mmsys hardware?

If the schema is not updated, a device tree author could attempt to use an
mt8167 mmsys node as a reset provider but forget to specify #reset-cells,
which would pass schema validation but fail to provide resets at runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819101853.4468=
1-1-l.scorcia@gmail.com?part=3D4
