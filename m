Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41A3F483C;
	Sun, 27 Sep 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518855; cv=none; b=S8h78CCbkwG0k4GY95dj2CPQohp7jbfo9lmiG9svAsFXNwVMJD2lNppPjcnwkV/BuPh0ihOsaBgz/KSnXZBhRwncU4dcC0CJnwCJZcRsqb/vrp2/lf/6gtuo1LEE7pP9L+1zrf+MPUSYJzCP8lI4vTI/CieTMzBxYXOx7jg/n4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518855; c=relaxed/simple;
	bh=6Dhi33etcFZ7DTImfsGr+MnwFSC0/uIHTuMEJUCiEDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7MhkGAjDPgORUGCdJS8IzjxWmJ38FHF/kybVYmut8jlZq+obYDbgNmRjuynN5l3paZSuPZHMb69bVI3kz0kucIU5vZnqzMXuHgh9HbZU5kFikbbX3fBYw9LhHiMgw1OpV+LtJR72kpZAEmJC95A4bFfWXZeAfA/a4zAju4OIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0Y169Ux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0Y169Ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02FD1F000FF;
	Sun, 27 Sep 2026 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790518853;
	bh=F6n0dhFkrCJFiAaU92IpNCnlxusgXMJox7E7Np/7y9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0Y169UxpwXJ4u6+hLp6XrpDoIwABmFIpyvhuAEQ9HK7mD0odXzAM25mO9128vREG
	 QZhUseUSiE7tCjMKV1n8mM6p+x9s1qA1r/ek4tzML+gbWbKQ1D5q72fljmyU4eZcmw
	 Lu2zET2/emU5snc5tQoDiyBkeDV/LypXpgYkDEfuJIWJkOnzf24JgahiPfSG9V/WAO
	 tfAlBtj5mFaUMMQnFabwF9bPY9A/eNBaM28NrC7jrcwvC+XVPDD3hEED7hSu1Qq/yO
	 5JU2ndGklGiOK5+tiKj+SqXUdgLGe8sMasZQeQ98ZYhxvXtyFVjxPiFgS8J/w0DRHc
	 iJdJlqQYAapLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add Exynos8855 watchdog
 compatible string
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260927143100.3576195-1-alim.akhtar@samsung.com>
References: <CGME20260927141253epcas5p371d497edc6756f13ce2215af4f380fb4@epcas5p3.samsung.com>
 <20260927143100.3576195-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 14:20:52 +0000
Message-Id: <20260927142052.E02FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: watchdog: missing comma in samsung,syscon-phandle desc=
ription
--

commit 8354ecfd36bd009fe5b5d0f2ef81e3977d3ba5fd
Author: Alim Akhtar <alim.akhtar@samsung.com>

dt-bindings: watchdog: Add Exynos8855 watchdog compatible string

This commit adds the samsung,exynos8855-wdt compatible string to the
watchdog device tree binding documentation. It updates the property
descriptions and constraint blocks to indicate that the Exynos8855 requires
the cluster-index and syscon-phandle properties.

> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> index a32c478315779..517c0e1cd78bf 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
[ ... ]
> @@ -52,13 +53,13 @@ properties:
>      enum: [0, 1, 2]
>      description:
>        Index of CPU cluster on which watchdog is running (in case of Exyn=
os850,
> -      Exynos990 or Google gs101).
> +      Exynos8855, Exynos990 or Google gs101).
> =20
>    samsung,syscon-phandle:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Phandle to the PMU system controller node (in case of Exynos5250,
> -      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos990 and gs101).
> +      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos8855 Exynos990 a=
nd gs101).

[Severity: Low]
This isn't a functional issue, but is there a missing comma between
Exynos8855 and Exynos990 in this updated description string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927143100.3576=
195-1-alim.akhtar@samsung.com?part=3D1
