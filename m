Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A403C98BE;
	Sat, 17 Oct 2026 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279421; cv=pass; b=UoUfnbkshvmokYYiowF4ij0NSam8QLZa2A3X6/yQFBFkgiva8v4WB5GjdbdT8qiaseQ8wITvLJANhPXdZbkRuhDFUUbXkkgDr7/8cJdLL3qGBMpjHJODb/lrXDjdz1t3dNlxI9UfwOJWkEvleRaRX/PHRvkIOIvkytk2BBXWLJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279421; c=relaxed/simple;
	bh=KBin77BuRwEF6l7gQkPxGfhe1whkHjA0o+4Eb93jJvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=twW58OspIh0Ggw2mI6L7X0yTaEzgzT+Ofj0E9+l7WShwWtq72XnWJYdKnfWn5D1Nq8cBb2WWEe7lRhUYQIpq+s991RAYc2XkBJZOARkUFcjBlicZBY6vJ9aYVGoDWPXSVYw0OGoDa8ZgCLwkRViDWqHTIoFD+8eUk/TxQmw5JGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=Th1AyCMq; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="Th1AyCMq"
ARC-Seal: i=1; a=rsa-sha256; t=1792279379; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=f9GWOW9KmjfA+x0JTUr33iINUzSkZ8v47jRyClUdyWtrO7qTiG1rq6OB5xg6IuWZnFmgW5SQAqL76ZFny1l28S+aVLL6FRX1jdFjkZN4Mg6HLZ9J6h9z526DZ+jI/5FiHcBAhnt4GassH1rpjEhOYnqiKXmTEOiosYe27xdNwG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792279379; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KBin77BuRwEF6l7gQkPxGfhe1whkHjA0o+4Eb93jJvY=; 
	b=gXTS5YCH0lc/PpHPotfnmdNEenltFK52sbHR5SxoLmsONqeFxGLCIyZJH8PJnkuyF4AxjNSveWHK8W3emuJiRcupUh0HQx/yEsWZlJdCC66fKFyhw60T01DlMCXBVZcxMa7rr3JYsbG4PLZmPh6hE+Sfi1Mh1HSzuTR2JK3LtXA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792279379;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KBin77BuRwEF6l7gQkPxGfhe1whkHjA0o+4Eb93jJvY=;
	b=Th1AyCMqe4b+zdZe5NnVx1eaO3/ff0mrJdhztIsKWgBnNWNQ24MAJCqPfNvocWYy
	jvOoiYZiJpUbyfDhx1rMqfnVDym/dJfy5fyAO35qZkG4OACdBlUezHKs/zfmm7MZGUd
	UOIcO7XR1pu48h3GE7mq3+ioubsJ+0rEccwbhtPI=
Received: by smtp.zoho.eu with SMTPS id 1792279377152970.0064595239699;
	Sun, 18 Oct 2026 01:22:57 +0200 (CEST)
Date: Sun, 18 Oct 2026 02:22:54 +0300
From: Igor Velkov <iav@iav.lv>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, p.zabel@pengutronix.de, mika.westerberg@linux.intel.com, andi.shyti@kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 0/5] watchdog: dw_wdt: reset clean up and pm
In-Reply-To: <25916fdf-22e2-4884-a78f-a7926a99b63e@roeck-us.net>
References: <20260320135624.223863-1-a.shimko.dev@gmail.com> <25916fdf-22e2-4884-a78f-a7926a99b63e@roeck-us.net>
Message-ID: <20261018-dw-wdt-shimko-v2-ask@iav.lv>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Artem,

Do you plan a v2? If not, I can pick the series up, keeping your
authorship, and address the review findings. Armbian carries it for
RK3399 boards (Helios64, ROCK Pi 4A): together with resets on the
rk3399 watchdog node, the watchdog no longer resets the board in s2idle.

Igor
