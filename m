Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E547CC67;
	Wed, 23 Sep 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162606; cv=none; b=OoCMQsQNHMlhj7cPtOxu/Gdphus+MOMilZvMJ+eevdEID2rK43CX2ebeGrBF9y03ANyt7wxVk+ykNZreHvDnB8d22/mNY1dFVDm+w+rrrKTnzb6A6vxUmO96lShlCsOt6RPDlETg95Sl6PuZ68LwCfwseukSWNDC603AOF71/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162606; c=relaxed/simple;
	bh=5ZL6nKCgnCOU+XXWayk+jRzdvu4jhqQCyymnJ8kTwAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=itcFlhmR0xVNtOFvabe3gCYEwcw08eizt4vK+m2iw8zvuFv+m86bgAiHyrtANbMe6KSSbtASkmZxfzzlpsS3q+kLl23plZ6sac33+W+/qLfEBDqILSy/EB7shZWcHLo0+BzISRh4xvVMjfRskwFNVnaf+aZ5yJL8plVn+U9WTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTqlZ3Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTqlZ3Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4031F000FF;
	Wed, 23 Sep 2026 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790162604;
	bh=5ZL6nKCgnCOU+XXWayk+jRzdvu4jhqQCyymnJ8kTwAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTqlZ3EtI9/494CGRjYhIvYWfnA7NBa+xIdti05tVoEEZ+2vkaDK2n5i/BeSwCHwo
	 Nog2+eZMSdSPXzWQoV1dfkAjP9jKt9vssGxkf0W17k6nj9EFeTrCBuDBLe/yeJCitA
	 NYKktymu9JI1g55LHIhC9++cx7f4bsgtfe7anbmTpBrVleHeSKHcLhyeE6IuVLIUh2
	 FS4KlRM//1Gkrf8gfcSfIIupi0sBbGklvIJAnB0bc4L/BGN8euHzeViv97mgoHtrq8
	 o/64TG3TI9CKlI41zLZVFzm0qwGTem6mM7G1TwaNlHtxJWd14LmGmsZxaylYkOqALv
	 +U+Mg7SXrWoLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mfd: da9061: make register CONFIG_I writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: mfd@lists.linux.dev, linux-watchdog@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260923111719.2032012-3-primoz.fiser@norik.com>
References: <20260923111719.2032012-1-primoz.fiser@norik.com>
 <20260923111719.2032012-3-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:23:24 +0000
Message-Id: <20260923112324.8A4031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mfd: commit message description is not capitalized
--

commit 5997b5e9bac966d2caba888fc1dfee5d188e81e0
Author: Andrej Picej <andrej.picej@norik.com>

mfd: da9061: make register CONFIG_I writable

This commit makes the configuration register CONFIG_I writable to allow
changing the watchdog mode.

> mfd: da9061: make register CONFIG_I writable

[Severity: Low]
This isn't a bug, but the MFD subsystem guidelines explicitly require the
description after the subsystem prefix to be capitalized. Should the commit
message title be updated to "mfd: da9061: Make register CONFIG_I writable"
to ensure it follows the standard Git history categorization for this
subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923111719.2032=
012-1-primoz.fiser@norik.com?part=3D2
