Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA07491587;
	Wed, 23 Sep 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162731; cv=none; b=jj4DhmnR2ymSAROq5nsQGWzRrlrXmv0qMKj1ZtOfLjX1C/a7voGk1zT+m5zQrwZFKoJEq0T+0c96YoAfFVMHcsqzAhV6701EyAhohTbCNS/nvuNOfW+kKGCzStIzCWFmNPMJ0MmtXuOwUEeIHmFCYTdr2yPAd0Y1uK28tg5lIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162731; c=relaxed/simple;
	bh=CGNvODspLiSAq9DfjOCWtmGk2rHxwt7j1BHAcmXAfQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duRM6wY2OwhhQtDkvOY8cqiTub4/A8R4Wzy3cddmGfbzO46zQXFS4MlRMrZDhtdFpeL4WIiCMzHar6Hzl2GMNcZuUmqGfpOqNpBmMztoZiQqUYG8R1HMrIbwpdUNDZlvLBDAmtga+4HJ4mam7nNlsa4vLH6m9STL9QSiusods0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYEBwvdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYEBwvdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EF21F00893;
	Wed, 23 Sep 2026 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790162723;
	bh=CGNvODspLiSAq9DfjOCWtmGk2rHxwt7j1BHAcmXAfQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYEBwvdlyAG2MnG9vVAxSP3P66ahHOZfx+2+JLvWBAoXsbRRrn6EG3hIozzd+snkY
	 xHkEPYSW1fh8XmZ5Un6AmC82pSJCqxPaMSGEW4Xw9rW+1K/LGyfzeNsB+npWlh6QcW
	 yXqhDIb290uDnlVLeUxhdlrCrj95NFy01wtD74oeoILuuiRsZJ3zrWrdp/qFyd4jDh
	 xxYUpJUnrX8OieJ1JYIrnQ61aBLkp9qyNIpBYENzYH5d5y5MDvqyogtORRGVRFWBb7
	 PJ0y5t8rKITD8K88yNPXg94D5AI1ThwzEzBYI3XYvsGQs+SzpOcHTx2taBo3hjmNXm
	 BoWEGViMfNqDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mfd: da9062: make register CONFIG_I writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org, linux-watchdog@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, imx@lists.linux.dev, mfd@lists.linux.dev
In-Reply-To: <20260923111719.2032012-2-primoz.fiser@norik.com>
References: <20260923111719.2032012-1-primoz.fiser@norik.com>
 <20260923111719.2032012-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:25:22 +0000
Message-Id: <20260923112522.86EF21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mfd: commit message capitalization violation
--

commit e25cc5ced7f3db4cd954295f961924b993742524
Author: Stefan Christ <s.christ@phytec.de>

mfd: da9062: make register CONFIG_I writable

This commit makes the configuration register CONFIG_I writable to allow
changing the watchdog mode.

> mfd: da9062: make register CONFIG_I writable

[Severity: Low]
This isn't a bug, but the MFD subsystem guidelines require the description
to always be capitalized after the subsystem prefix. Should "make" be
capitalized to "Make" to align with this convention?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923111719.2032=
012-1-primoz.fiser@norik.com?part=3D1
