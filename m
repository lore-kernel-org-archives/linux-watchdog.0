Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5781ACA;
	Mon, 11 May 2026 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475191; cv=none; b=HRSVBoFxmb/j2xwqUoj1vvGO0j2uecoaTzp3zU2W1/R5DD/KLW3UWiUBwJlsgz+YNHcxYXoe5cAv9HN0W+Iz+Vr3nRVKZo72318WlH5mX6AmJz10fixdZVQ0fSjVL2d0/a2vuVOYIHXrr9jjYDUICBDuW//92qVBbbVmlEpla2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475191; c=relaxed/simple;
	bh=nRKUAY6KOcFsKplKY6bzxzpkaP8ZfDba6uWk+Kd1qqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=H9DaLVP/IcLbNHX1uAspRU9qSXWxgDkadWRSJAnvCobHjAsm4pI7f3JyEWFv59sKWt4O98cDzIzKsXNV9sX3vv3BrvQs1YntulyIA/dxTXpJmRJQNrmzRZUU5Q9EytXn82OU1vWxU0TpOBPNNPkQTyGRow96YYSZ/DH/I16Oglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AmUCsxKS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AmUCsxKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=nRKUAY6KOcFsKplKY6bzxzpkaP8ZfDba6uWk+Kd1qqQ=; b=A
	mUCsxKS98+VhtiVALfpmVgibhqTuoffds8SmOI5yJACNMO2QXKqFSnivwiRfVX3o
	/8/5v+EthwA6B7BZqH1LZpq7ZpWkWVYnuvtCTJXj7rqbqlnP/uGzrzUx4ccmLw5R
	La8J1Y0mtGhqQcwFNSgQbkDRT/ztB1HXAFSO4VGIRw=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-112 (Coremail) ; Mon, 11 May 2026 12:52:35 +0800
 (CST)
Date: Mon, 11 May 2026 12:52:35 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH] watchdog: wdt_pci: Fix shared IRQ storm and complete
 system lockup
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <a32f5c51-1e72-4208-92db-c5a000f3d43d@roeck-us.net>
References: <20260509121655.275311-1-w15303746062@163.com>
 <f182256d-0623-4c9b-a18a-acca8457bb08@roeck-us.net>
 <1fc8bb5a.1346.19e14a548fb.Coremail.w15303746062@163.com>
 <5acea672-0550-478e-8f49-e5e43c72d7e2@roeck-us.net>
 <15f8c180.3519.19e1501ebbc.Coremail.w15303746062@163.com>
 <a32f5c51-1e72-4208-92db-c5a000f3d43d@roeck-us.net>
X-NTES-SC: AL_Qu2cCvicukku4yCeY+kfmU0Qguw9Xcq5uPkj34FWN5t8jDnp4R4jRF1kG13r1uy9ByShnCqafgd/9OtBZLhKfYkVjjTDdufw97xTV6HKHNPfgQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <403be50f.4887.19e15613e85.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cCgvCgDnanyTYAFqmpygAA--.6373W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDABMX+moBYJNuMwAA37
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkZyb206IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KCkhp
IEd1ZW50ZXIsCgpQb2ludCB0YWtlbi4gWW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0IHRoYXQgcmVs
eWluZyBvbiBhbiB1bnZlcmlmaWVkIG1hY3JvIHRvIHN5bnRoZXNpemUgaGFyZHdhcmUgYmVoYXZp
b3IgaXMgZmxhd2VkLiBJIGFwb2xvZ2l6ZSBmb3Igbm90IG1ha2luZyB0aGUgdmlydHVhbGl6ZWQg
YW5kIHN5bnRoZXNpemVkIG5hdHVyZSBvZiB0aGlzIHRlc3Qgc2V0dXAgY2xlYXIgaW4gdGhlIGlu
aXRpYWwgcGF0Y2ggZGVzY3JpcHRpb24uIAoKU2luY2UgdGhlIHRydWUgcGh5c2ljYWwgaGFyZHdh
cmUgYmVoYXZpb3IgY2Fubm90IGJlIHZlcmlmaWVkLCBhbmQgdGhlIGRyaXZlciBkb2VzIG5vdCBh
Y3RpdmVseSBldmFsdWF0ZSB0aGF0IGJpdCwgd2UgYWdyZWUgdGhhdCBhcHBseWluZyBhIHBhdGNo
IGJhc2VkIG9uIHRoaXMgYXNzdW1wdGlvbiBpcyBpbmFwcHJvcHJpYXRlLiAKCkkgd2lsbCBkcm9w
IHRoaXMgcGF0Y2guIFRoYW5rIHlvdSBmb3IgdGhlIHJpZ29yb3VzIHJldmlldyBhbmQgZm9yIHBv
aW50aW5nIG91dCB0aGlzIGxpbWl0YXRpb24gaW4gb3VyIHRlc3RpbmcgbWV0aG9kb2xvZ3kuCgpC
ZXN0IHJlZ2FyZHMsCk1pbmd5dQoKCgoKCgoKCgoKQXQgMjAyNi0wNS0xMSAxMjozOToyNiwgIkd1
ZW50ZXIgUm9lY2siIDxsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOgo+SGksCj4KPk9uIDUvMTAv
MjYgMjA6MDgsIHcxNTMwMzc0NjA2MiB3cm90ZToKPj4gCj4+IAo+PiBGcm9tOiBNaW5neXUgV2Fu
ZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+Cj4+IAo+PiBIaSBHdWVudGVyLAo+PiAK
Pj4gWW91IGFyZSBjb3JyZWN0OyBzdGFuZGFyZCBRRU1VIGRvZXMgbm90IHN1cHBvcnQgdGhlIFdE
VDUwMC81MDEuCj4+IAo+PiBXZSBvYnNlcnZlZCB0aGlzIGlzc3VlIHVzaW5nIERldkdlbiwgYW4g
YXV0b21hdGVkIGZyYW1ld29yayB3ZSBhcmUgZGV2ZWxvcGluZy4gSXQgc3ludGhlc2l6ZXMgUUVN
VSB2aXJ0dWFsIGRldmljZSBtb2RlbHMgZGlyZWN0bHkgZnJvbSBMaW51eCBkcml2ZXIgc291cmNl
IGNvZGUgdXNpbmcgTExNIGd1aWRhbmNlLCBhbGxvd2luZyB1cyB0byBmdXp6IGxlZ2FjeSBvciBv
YnNjdXJlIGRyaXZlcnMgdGhhdCBsYWNrIHBoeXNpY2FsIGhhcmR3YXJlIG9yIG9mZmljaWFsIGVt
dWxhdG9ycy4KPj4gCj4+IEJlY2F1c2UgdGhlIHN5bnRoZXNpemVkIGRldmljZSBpcyBhbiBpbXBl
cmZlY3QgbW9kZWwsIGl0IGdlbmVyYXRlZCB1bmV4cGVjdGVkIGludGVycnVwdCBsb2FkcyBvbiBh
IGhlYXZpbHkgc2hhcmVkIFBDSSBJUlEgbGluZSAoc2hhcmVkIHdpdGggdGhlIGkyYy1pODAxIGNv
bnRyb2xsZXIgaW4gb3VyIHNldHVwKS4gSG93ZXZlciwgdGhpcyBzdWNjZXNzZnVsbHkgZXhwb3Nl
ZCBhIHJlYWwgbG9naWMgZmxhdzogdGhlIGB3ZHRfcGNpYCBkcml2ZXIgcmVnaXN0ZXJzIGFuIGBJ
UlFGX1NIQVJFRGAgaGFuZGxlciBidXQgZmFpbHMgdG8gdmVyaWZ5IHRoZSBgV0RDX1NSX0lSUWAg
Yml0LiBJdCBlcnJvbmVvdXNseSBjbGFpbWVkIHRoZSBpbnRlcnJ1cHRzLCBieXBhc3NlZCB0aGUg
a2VybmVsJ3Mgc3B1cmlvdXMgSVJRIGRlZmVuc2VzLCBhbmQgY2F1c2VkIGEgbGl2ZWxvY2suCj4+
IAo+PiBJIHVuZGVyc3RhbmQgdGhpcyBoYXJkd2FyZSBpcyBlc3NlbnRpYWxseSBvYnNvbGV0ZS4g
VGhlIHBhdGNoIHByb3ZpZGVzIGEgcHVyZWx5IGRlZmVuc2l2ZSBmaXggZm9yIGEgbGVnaXRpbWF0
ZSBBUEkgdmlvbGF0aW9uICh1bnZlcmlmaWVkIHNoYXJlZCBJUlEpLgo+PiAKPj4gSWYgYXBwbHlp
bmcgdGhpcyBhZGRzIHVubmVjZXNzYXJ5IGNodXJuLCBwbGVhc2UgZmVlbCBmcmVlIHRvIGRyb3Ag
aXQsIG9yIHBlcmhhcHMgY29uc2lkZXIgbWFya2luZyB0aGUgZHJpdmVyIGFzIEJST0tFTi4gSSBs
ZWF2ZSBpdCBlbnRpcmVseSB0byB5b3VyIGp1ZGdtZW50Lgo+PiAKPgo+VGhhdCBpcyBlbnRpcmVs
eSBub3QgdGhlIHByb2JsZW0uIFRoZSBwcm9ibGVtIGlzIHRoYXQgeW91ciBBSSBpbXBsZW1lbnRl
ZAo+YSBRRU1VIGVtdWxhdGlvbiB3aXRob3V0IHJlYWxseSBrbm93aW5nIHdoYXQgdGhlIGhhcmR3
YXJlIGlzIGRvaW5nIHdoaWxlCj5ndWVzc2luZyB3aGF0IHN0YXR1cyBiaXRzIHVudXNlZCBieSB0
aGUgZHJpdmVyIG1lYW4gZm9yIHRoZSByZWFsIGhhcmR3YXJlLgo+V2UgKGFuZCB0aGUgQUkpIGFj
dHVhbGx5IGRvbid0IGtub3cgd2hhdCB0aGUgV0RDX1NSX0lSUSBkb2VzLCBvciBpZiBpdAo+aXMg
aW5kZWVkIGxvdyBhY3RpdmUuIFRoYXQgaXMganVzdCBhIGd1ZXNzLiBJIGNhbiBub3QgYWNjZXB0
IGEgcGF0Y2gKPmJhc2VkIG9uIGEgZ3Vlc3MsIG11Y2ggbGVzcyBvbmUgbWFraW5nIHVuY29uZmly
bWVkIGNsYWltcy4KPgo+SWYgdGhlIGRyaXZlciBpcyBpbmRlZWQgdW51c2VkIG9yIG9ic29sZXRl
IGlzIGEgY29tcGxldGVseSBkaWZmZXJlbnQKPnF1ZXN0aW9uLiBNYXJraW5nIGl0IGFzIEJST0tF
TiB3aXRob3V0IHJlYWwgZXZpZGVuY2UgdGhhdCBpdCBpcyBpbmRlZWQKPmJyb2tlbiwganVzdCBi
ZWNhdXNlIHNvbWUgQUkgYmVsaWV2ZXMgdGhhdCBpdCBpcyBicm9rZW4sIHdvdWxkIGJlCj5pbmFw
cHJvcHJpYXRlLgo+Cj5QbGVhc2Ugbm90ZSB0aGF0IEkgYWxzbyBmaW5kIHRoZSBwYXRjaCBkZXNj
cmlwdGlvbiBpbmFwcHJvcHJpYXRlIGFuZAo+bWlzbGVhZGluZy4gSXQgc3VnZ2VzdHMgdGhhdCB0
aGUgcHJvYmxlbSB3YXMgb2JzZXJ2ZWQgb24gcmVhbCBoYXJkd2FyZSwKPndoaWxlIGl0IHdhcyBh
Y3R1YWxseSBvYnNlcnZlZCB3aXRoIGEgcWVtdSBpbXBsZW1lbnRhdGlvbiBpbXBsZW1lbnRlZCBi
eSBBSQo+YmFzZWQgb24gdGhlIGRyaXZlciBpdHNlbGYsIGluY2x1ZGluZyBndWVzc3dvcmsgYWJv
dXQgc3RhdHVzIGJpdHMgdW51c2VkCj5ieSB0aGUgZHJpdmVyLgo+Cj5HdWVudGVyCg==
