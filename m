Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B449B210;
	Wed, 23 Sep 2026 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162637; cv=none; b=d3oelFSNDegUVYcJyb8Olsw/AzXjmcimn5J54mn+LZC+MvmnlZrpGpkdQGLI5XgAg9rscAKq+YmS+nXqvo1VRG+qHHs8CBn7s8zG+2e/7VnsEF/UOXdDWqLP7MX2n6wl8+Dt38v4CvXBAZ0oI0UZeA24A1zrTBsyIHX2KjWslg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162637; c=relaxed/simple;
	bh=dpDcte4Wh/j36V0vSnX5gQhfaousmrIzhLC7jvwKBYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XsV3F0/5PRA8xlnblt7j9l1XcG3ydPtxB8BQqoiAm1NlzCpF5kCGRK/r0wHcTHFUjxyTdgaVkKufOQHxDNEBCHRN0hHERNZL88/71677FKqy5npP1QslJ4HsWz+j8gQxa2bBO3ZarY8l3f5+zPt40jEW6SQobzXBBJRdz4WtAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXyyxuH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXyyxuH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CF1F000FF;
	Wed, 23 Sep 2026 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790162636;
	bh=dpDcte4Wh/j36V0vSnX5gQhfaousmrIzhLC7jvwKBYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXyyxuH9Uah0essmVGz9GNXuGM0ym6gCkrm3qNvSAMsYsOBNZrSrCSDzaa6VL4EEd
	 4IKOYC9xiODxL2aIOfrV9d9YTKHgC8bwT3EuJLv1v5zGdHxakObOcoFX1dYwprlszB
	 La9QryRIg5T+VGm6H8/r3PYb/+KG57VLKFYol4DALy/CdOs9+Y3Na1VQ1WfaZhkhBr
	 ZJMqtk7m5IIeND7Ar+lDZfLgFetRUSbU755mpLpXJXhpuWch6R5kIh2je5RtF1BBdA
	 4UaT+2cQ0YV6lsW1r7rly4uj2Aj2woT03p3b2MKy7eUTknoyyor5P9oFDzvZxYmadN
	 YN+j6zP9Mr+4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: imx6: phycore-som: set watchdog timeout
 mode to shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: conor+dt@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260923111719.2032012-5-primoz.fiser@norik.com>
References: <20260923111719.2032012-1-primoz.fiser@norik.com>
 <20260923111719.2032012-5-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:23:55 +0000
Message-Id: <20260923112355.7F7CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Andrej Picej <andrej.picej@norik.com>
>=20
> Enable system restart when the watchdog timeout occurs.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923111719.2032=
012-1-primoz.fiser@norik.com?part=3D4

