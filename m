Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02C2F5313;
	Fri, 17 Jul 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307893; cv=none; b=Vu6KteuXmaHQzRZq0WtG5Jjc2V8SKXDGElmozseZXzCwKu54sYajwWqE+qELUWJFmSNhIGHpfReg4IKkupp79q1FQBQA7TRETTY3gRHkDOs3tr1imzD/v9c5Bha5qdIwYJFinnhJ3pdLx9JD0ZEA6ii5qm8fL9XtacD+zlLgiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307893; c=relaxed/simple;
	bh=nVq60RNRmpowVsSboKQUdjT+oGIzcXNefAHii/o7PqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5tupANTQVnA1Mwroqpxcq2lzFQjJ3JR25tqr8o6TmIZpDTVk1XoCBfVcBTyfgs6BN2XiPCV4o8qvhl6enTExcdBIYhY4mtmjtK2A5PNdzWe+2Ehlld2X6oIlaTiB88qvc7fm4pQ8AaNkA2eHLkxjzVadRn8I4aFYf7A1upmQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpSZ2+zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpSZ2+zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CCF1F000E9;
	Fri, 17 Jul 2026 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307892;
	bh=os2S+eNKU/s2p47ff8nfUB8pGOOETLvsrnX37QsbeXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpSZ2+zrfgGMKwea89PK3w1Vl2UDeaL5maRML7CUhAYqO9hHlqKDQD+xYIAfHn1ix
	 Du6bBcRctC6ORJuAac+SsK+g6dt2qAj4h4KZvtxUVG2zG1/6tuSDi42lhshZTm7y55
	 5UBPsTlX/X8M6IoYArhrwqHiRqfAsnk9GLGXOg657E67EjA1FJeWk5AF1oLFhEsmg6
	 vzzJz+MgYSNQcmWJfL/8u1dEAayu1VjJWuyKSf9+HxxMPie9wrvAatKXMWnti9ckgo
	 bJCjW6/EX0CegDfOb5yNWx8250Mg1nKRsH3ht0fwMWxiNLGFOH2rUYrsKo0LNp5W+c
	 7Cs1o4wThik1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260717163959.714561-2-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:04:51 +0000
Message-Id: <20260717170451.C0CCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch adds reset provider capabilities for MT6589 without updat=
ing the corresponding YAML schema to require `#reset-cells`.
--

--- Patch [1]: [PATCH v2 1/7] dt-bindings: reset: Add MT6589 toprgu reset I=
Ds ---
commit 1610507569a41df45fcf55f93c1df6323ff7d422
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: reset: Add MT6589 toprgu reset IDs

This commit introduces the reset constants for the 12 MT6589 toprgu
resets to be used as a reset provider.

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
> +
> +/* TOPRGU resets */

[Severity: Low]
Does Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml need =
to
be updated to require #reset-cells when using mediatek,mt6589-wdt?

When adding reset provider capabilities for a hardware variant, the schema
typically requires an allOf/if-then block to add #reset-cells to the requir=
ed
list. Without this update, a device tree node utilizing the MT6589 watchdog
as a reset provider could omit #reset-cells and still silently pass
dt_binding_check validation.

> +#define MT6589_TOPRGU_INFRA_SW_RST		0
> +#define MT6589_TOPRGU_MM_SW_RST			1

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717163959.7145=
61-1-l.scorcia@gmail.com?part=3D1
