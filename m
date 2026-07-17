Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41742E8C3;
	Fri, 17 Jul 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301916; cv=none; b=CxLDAPVObwuMlz5J4nKD8UTf9anM4FXaWfskBL0+zDWrMDUO9wp5xV/ZRQmTJeBGk89jfDxmJDM5HqoeJjqdgp61S907/kD2p/kRcq2BfXIH0yogwAeSapPasRPAfx3GIFsI0pfxszU3hlsMdBBDFlT39s5qLbmfpHMWWqf1Hxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301916; c=relaxed/simple;
	bh=tZiO8lSZLE/keV9Gu5FSWu4lN6md6rKk20R60ZG5yYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onbITrKjRuJJTsvqFtYCCz18dmDG9SHf90SwbcCDWPeXriilocOoN6hmlmmpR7tE3qRNC7fc7NJl50S13uUHzSZE8f4uQRbkPh5Jdimhvb8xtMdotVjXymGOtwhTxDaBvP3ZDshLsKaVXiCfSHlTAlwlwx9XH/2LwaST/sMuV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI0zHGSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI0zHGSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623261F00ACA;
	Fri, 17 Jul 2026 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784301910;
	bh=tZiO8lSZLE/keV9Gu5FSWu4lN6md6rKk20R60ZG5yYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GI0zHGSqLzNIIfkJTeCWBVc3h1zxgHibBYaLej63XmKwzSGnLnCR1C5obqRgnw7Iu
	 AA6SkF4jKGsQZam08m9fBT9hVYWhWEg5HfQ2tc+BLcrZloEPp6wXhpG/Qw6cMYEtGQ
	 hAw31ZvZbQTbfS8SuCOn/v+XLISxRxANifoP3v6o8kcvHG5dGZcmemDxTmjfg4iJ4x
	 0N18stwOEIADIuZG/mbamkXcQ/9uvnF7w6c+mm0H21FpmDdME2ON1YQiG3uazVZdby
	 90xxWPzInMjqqgg97OYtaIwxSH4rHDSg3czhHHxVI6q2VNaOMBbSuQUlGstC/Osyl2
	 DW8LJ5k0cCGCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260717151134.678839-2-l.scorcia@gmail.com>
References: <20260717151134.678839-1-l.scorcia@gmail.com>
 <20260717151134.678839-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:25:08 +0000
Message-Id: <20260717152509.623261F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The watchdog binding schema is not updated to require `#reset-cells=
` for the MT6589 watchdog after it gained reset provider capabilities.
--

--- Patch [1]: [PATCH 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs =
---
commit 8e7eeaa8443a5e5f9043d85f10bedf8f05afe2b3
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: reset: Add MT6589 toprgu reset IDs

This commit adds a new header file defining reset IDs for the 12 MT6589 top=
rgu
resets.

> diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include=
/dt-bindings/reset/mediatek,mt6589-resets.h
> new file mode 100644
> index 0000000000000..ee08c39df5131
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT6589
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT6589

[Severity: Low]
Does the MT6589 watchdog binding schema in
Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml also need =
an
update to require the #reset-cells property?

Since the MT6589 watchdog is gaining reset provider capabilities with these
constants, device tree nodes omitting #reset-cells might incorrectly pass
schema validation unless an if-then block is added to the watchdog schema to
enforce it.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717151134.6788=
39-1-l.scorcia@gmail.com?part=3D1
