Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703603;
	b=ognekYCdl/1iWcZOewZCNDwc5cqx79MJY4ByhB7i0LdBr4N+TdvhXy1qlfB+zzBhdmT+
	 Ts6feNXksQMkTrlJ1f+fC3qM9/VvkB93O70OC6kjsOUz/iMEipkvsP0ePxEnVo9df7Dbi
	 6qFFoEalQmhp5Uf9UHEUoL68eYr/zYt0mC3209IiWoADGxb8RNbg91IxbLlGTZaDJqSYy
	 OQ5LQw681WKEuNXhge6/vh8gv0q0WEKbQwk43tCArvpNqwPjl8WyZeXqgEMypC+nMqmXs
	 wQ4dJ+ExAsu2SshqmRL6ejaXvMcbh/k4kkTuwXRI6yVpoLgfBq6X9iaji9l1lZSyqlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703603;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VaGcSghvysR6PQzeDVXi0PWo21qEdVpziK/qIjfASr8=;
	b=xauhNLXvybjmc8ec8IvlM+Xy3YWW47zpp93y7wiSDdz82S5XGe6FvYLNgLXjxLzfkgUH
	 doYhkQmd4kAHn3hxpWgDkFChx81tcTjTHabyU+cuAa/VWocNrYjtFTOY7iqCZe9xQjVtn
	 UcXjVnO/2z4x89ejnqHPert7bQ44WfCUOq6B+eua7OJJWeLJBaoUYk7v7ncppIr9fsP7D
	 P360FolH94eI+rDfkTgvgArngZbVS+kuo3ptu6NpNpkniRl2jkY0t+ouNviJ++cJoErXb
	 Rb5ipn1xhL69ica/RUTYeOzuuFQobAdkzXTME/3bn84HeHYGgthIiNuB6/xKQXUOa1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b="Qwvdkx/A";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC0606A31A;
	Thu, 22 Oct 2026 21:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89AC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Qwvdkx/A
ARC-Seal: i=1; a=rsa-sha256; t=1792703550; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GzsWyJyAiZ4dx7T7HXf2yJAjOfbzyxgkCpViz5hZ9MAp0T0jVscdc9HogjXLoeX/TzvkQ+jd3Wa0nxGVuocmXCvZ80mlsss8JJJMiGnMryo8ExyWG5w9kJ9zXZPKSI+2bYB1/O9M1lzgKRAcx4WGSuSZQUJ8LIZMHvFQkUtPWAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792703550; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VaGcSghvysR6PQzeDVXi0PWo21qEdVpziK/qIjfASr8=; 
	b=LkL2sTAq826GU+HmERMPZWyH6nlo0w/unMTcbKoktb8Hxvoz6tNucJvHrhcqQE6Go0IkNKktpghiui5Ato3Cc8Dh0cd1nqac9OiCtPYxSrnY/48CcEaYWL8+K40fpfE1LYQ3RdSe/MS+ZjqymQRWOJlhdDppDP8GXdWAeuEuyYQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792703550;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VaGcSghvysR6PQzeDVXi0PWo21qEdVpziK/qIjfASr8=;
	b=Qwvdkx/A/S57rw5/ApAI59E8Wph//WVa2zv5oj6wIW1drSl7vyFtInuW/f34XZry
	E1awu/FRLWGFD5EymyRFRIgaC9MD/e43skwz1tVj0OnH7PX3yuH65VpNt5R5b+6ubKc
	qUj8Zxk/52r8/jy6XSl6936Evjh0Sh6Plw+2dguA=
Received: by smtp.zoho.eu with SMTPS id 1792703547436668.4662411198989;
	Thu, 22 Oct 2026 23:12:27 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, p.zabel@pengutronix.de, Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com, andi.shyti@kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH v2 0/3] watchdog: dw_wdt: fix reset line management
Date: Fri, 23 Oct 2026 00:15:00 +0300
In-Reply-To: <20261022134354.534642-1-a.shimko.dev@gmail.com>
References: <20261022134354.534642-1-a.shimko.dev@gmail.com>
Message-ID: <20261023-dw-wdt-shimko-v2-tested@iav.lv>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tested on Helios64 and ROCK Pi 4A (RK3399) on top of 7.3, with
resets = <&cru SRST_P_WDT0> added to the watchdog node locally (not in
mainline yet). With the watchdog daemon at 60 s timeout, s2idle for 90 s:
3/3 on ROCK Pi 4A and 4/4 on Helios64 without a reset; after resume the
watchdog is alive (killing the daemon without magic close resets the board
after ~60 s on both).

Tested-by: Igor Velkov <iav@iav.lv>
