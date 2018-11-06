
# -*- coding: utf-8 -*-
import oss2

# 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建RAM账号。
auth = oss2.Auth('LTAInZKHvehZBTLE', 'ZFqPNZTpfU7ydsDbbFHDr3zVRkMDJY')
# Endpoint以杭州为例，其它Region请按实际情况填写。
bucket = oss2.Bucket(auth, 'http://oss-cn-shanghai.aliyuncs.com', 'bench-ios')

# <yourLocalFile>由本地文件路径加文件名包括后缀组成，例如/users/local/myfile.txt
bucket.put_object_from_file('bench.json', 'bench.json')

print('upload success!')
print('http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json')
